import Foundation
import PromiseKit

struct Fonts {
    private static let queue = DispatchQueue(label: "dotfiles-fonts")

    static func install() throws -> Promise<Void> {
        try? removeOldFontDirectory()
        return Git.clone("git@github.com:hallee/fonts.git")
    }

    private static func removeOldFontDirectory() throws {
        let path = FileManager.default.currentDirectoryPath + "/fonts"
        try FileManager.default.removeItem(atPath: path)
    }

}
