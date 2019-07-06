import Foundation

struct Constants {
    static let home = URL(fileURLWithPath: FileManager.default.homeDirectoryForCurrentUser.path)

    /// Clone location for git repos
    static let codeLocation = home.appendingPathComponent("Code")

    /// Repo containing font files to install
    static let fontsRepo = "git@github.com:hallee/fonts.git"

    /// Repo containing `Installed Packages` and `Packages` for Sublime Text
    static let sublimeSettingsRepo = "git@github.com:hallee/sublime-settings.git"

    /// Repo containing app icons for customization
    static let appIconsRepo = "git@github.com:hallee/app-icons.git"
}
