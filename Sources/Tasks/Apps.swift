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

    static func install(_ console: Console) -> Promise<Void> {
//        let loadingBar = console.loadingBar(title: "Installing apps...")
//        loadingBar.start() /// TODO: crashes

        return firstly {
            Brew.cask(appsToInstall)
        }.ensure {
//            loadingBar.succeed()
        }
    }

}
