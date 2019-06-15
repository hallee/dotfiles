import Foundation
import ConsoleKit
import PromiseKit

struct SublimeText {

    static let sublimeSettingsPath = Constants.home
        + "/Library/Application Support/Sublime Text 3/"

    static func install() -> Promise<Void> {
        return firstly {
            Brew.cask(["sublime-text"])
        }.then {
            downloadSettings()
        }.then {
            symbolicLinkSettings()
        }
    }

    private static func downloadSettings() -> Promise<Void> {
        return Git.clone(Constants.sublimeSettingsRepo, into: Constants.codeLocation)
    }

    private static func symbolicLinkSettings() -> Promise<Void> {
        return Promise<Void> { seal in
            guard let settingsPath = settingsFolderPath else {
                seal.resolve(nil)
                return
            }

            Output.shared.print("==> Linking Sublime Text settings from \(settingsPath) to \(sublimeSettingsPath)")

            let searcher = FileManager.default.enumerator(
                at: URL(fileURLWithPath: settingsPath),
                includingPropertiesForKeys: nil,
                options: [.skipsPackageDescendants,
                          .skipsHiddenFiles,
                          .skipsSubdirectoryDescendants]
            )
            while let file = searcher?.nextObject() as? URL {
                let destinationPath = sublimeSettingsPath + file.lastPathComponent
                try FileManager.default.createSymbolicLink(
                    at: URL(fileURLWithPath: destinationPath),
                    withDestinationURL: file
                )
            }

            seal.fulfill()
        }
    }

    private static var settingsFolderPath: String? {
        guard var folderName = URL(
            string: Constants.sublimeSettingsRepo
        )?.lastPathComponent else {
            return nil
        }

        folderName.removeLast(4) // remove '.git'

        let settingsPath = Constants.codeLocation + "/" + folderName + "/"

        return settingsPath
    }

}
