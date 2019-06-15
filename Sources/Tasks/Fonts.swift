import Foundation
import PromiseKit

struct Fonts {

    private static var fontPath: String {
        FileManager.default.currentDirectoryPath + "/fonts"
    }

    private static var fontInstallPath: String {
        FileManager.default.homeDirectoryForCurrentUser.path + "/Library/Fonts"
    }

    static func install() -> Promise<Void> {
        try? removeFontDirectory()
        return firstly {
            Git.clone(Constants.fontsRepo)
        }.then {
            recursivelyFindAllFonts()
        }.then { urls in
            installFonts(urls)
        }.ensure {
            try? removeFontDirectory()
        }
    }

    /// Searches for fonts based on their type identifier (UTI)
    private static func recursivelyFindAllFonts() -> Promise<[URL]> {
        return Promise<[URL]> { seal in
            var fonts = [URL]()

            let searcher = FileManager.default.enumerator(
                at: URL(fileURLWithPath: fontPath),
                includingPropertiesForKeys: [.typeIdentifierKey],
                options: [.skipsPackageDescendants, .skipsHiddenFiles]
            )

            Output.shared.print("==> Searching for fonts...")

            while let file = searcher?.nextObject() as? URL {
                guard let identifier = try? file.resourceValues(
                    forKeys: [.typeIdentifierKey]
                ).typeIdentifier else { continue }
                /// Seems reasonable that the UTI name contains "font" for fonts,
                /// there probably are edge cases but oh well
                guard identifier.contains("font") else { continue }

                fonts.append(file)
            }

            seal.fulfill(fonts)
        }
    }

    private static func installFonts(_ fonts: [URL]) -> Promise<Void> {
        return Promise<Void> { seal in
            Output.shared.print("==> Found \(fonts.count) fonts, installing...")

            fonts.forEach { font in
                try? FileManager.default.moveItem(atPath: font.path,
                                                  toPath: fontInstallPath)
            }
            seal.fulfill()
        }
    }

    private static func removeFontDirectory() throws {
        try FileManager.default.removeItem(atPath: fontPath)
    }

}
