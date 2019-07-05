import Foundation
import ConsoleKit
import PromiseKit
import AppKit

struct Icons {

    static var appsAndIcons = [
        "Sublime Text.app": "Sublime Text"
    ]

    static func install() -> Promise<Void> {
        return firstly {
            downloadIcons()
        }.then {
            installIcons()
        }
    }

    private static func downloadIcons() -> Promise<Void>  {
        if let iconsFolderPath = iconsFolderPath {
            try? FileManager.default.removeItem(atPath: iconsFolderPath)
        }
        return Git.clone(Constants.appIconsRepo, into: iconsFolderPath)
    }

    private static func installIcons() -> Promise<Void> {
        return Promise<Void> { seal in
            defer { seal.fulfill() }
            guard let iconsFolderPath = iconsFolderPath else { return }
            let iconsFolderURL = URL(fileURLWithPath: iconsFolderPath)

            let iconURLs = findIconFiles(in: iconsFolderURL)
            let iconsAndMatchingApplications = findMatchingApplications(for: iconURLs)

            for (iconFile, applicationFile) in iconsAndMatchingApplications {
                guard let application = applicationFile?.path else { continue }
                let iconImage = NSImage(contentsOf: iconFile)
                let success = NSWorkspace.shared.setIcon(iconImage, forFile: application, options: [])
                print(success)
                print(application)
            }
        }
    }

    /// Recursively finds all `.icns` files in a given directory.
    private static func findIconFiles(in directory: URL) -> [URL] {
        let searcher = FileManager.default.enumerator(
            at: directory,
            includingPropertiesForKeys: [.typeIdentifierKey],
            options: [.skipsPackageDescendants, .skipsHiddenFiles]
        )

        var iconURLs = [URL]()

        while let file = searcher?.nextObject() as? URL {
            guard let identifier = try? file.resourceValues(
                forKeys: [.typeIdentifierKey]
            ).typeIdentifier else { continue }
            /// `com.apple.icns`
            guard identifier == "com.apple.icns" else { continue }
            iconURLs.append(file)
        }

        return iconURLs
    }

    private static func findMatchingApplications(for iconFiles: [URL]) -> [URL: URL?] {
        var iconsAndMatchingApplications = [URL: URL?]()

        let searcher = FileManager.default.enumerator(
            at: URL(fileURLWithPath: "/Applications/"),
            includingPropertiesForKeys: [.typeIdentifierKey],
            options: [.skipsPackageDescendants, .skipsHiddenFiles]
        )

        while let file = searcher?.nextObject() as? URL {
            guard let identifier = try? file.resourceValues(
                forKeys: [.typeIdentifierKey]
            ).typeIdentifier else { continue }
            /// `com.apple.application-bundle`
            guard identifier == "com.apple.application-bundle" else { continue }

            for iconFile in iconFiles {
                guard let applicationName = iconFile.lastPathComponent.split(separator: ".").first else { continue }

                if file.lastPathComponent.contains(applicationName) {
                    iconsAndMatchingApplications[iconFile] = file
                }
            }

        }

        return iconsAndMatchingApplications
    }

    private static var iconsFolderPath: String? {
        guard var folderName = URL(
            string: Constants.appIconsRepo
        )?.lastPathComponent else {
                return nil
        }

        folderName.removeLast(4) // remove '.git'

        let iconsPath = Constants.codeLocation.appendingPathComponent(folderName).path

        return iconsPath
    }

}
