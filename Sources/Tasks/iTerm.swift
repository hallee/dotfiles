import Foundation
import PromiseKit

struct iTerm {

    /// Installs and configures iTerm2 with zsh
    static func install() -> Promise<Void> {
        return firstly {
            Brew.run("tap", "homebrew/cask-versions")
        }.then {
            Brew.cask(["iterm2-nightly"])
        }.then {
            Brew.run("install", "zsh", "fzf", "antigen", "hub")
        }.then {
            installFuzzyFind()
        }
    }

    private static func installFuzzyFind() -> Promise<Void> {
        return Promise<Void> { seal in
            🐚.run(command: ["/usr/local/opt/fzf/install",
                               "--completion",
                               "--key-bindings",
                               "--update-rc"]) {
                seal.fulfill()
            }
        }
    }

}
