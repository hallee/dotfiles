import Foundation
import ConsoleKit
import PromiseKit

struct Apps {

    private static let appsToInstall = [
        "sublime-text",
        "github",
        "discord",
        "istat-menus",
        "bartender",
        "geekbench",
        "google-chrome",
        "firefox",
        "iconjar",
        "imageoptim",
        "audio-hijack"
    ]

    static func install() -> Promise<Void> {
        return Brew.cask(appsToInstall)
    }

}
