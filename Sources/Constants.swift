import Foundation

struct Constants {
    static let home = FileManager.default.homeDirectoryForCurrentUser.path

    /// Global git configuration
    static let globalGitignorePath = home + "/.gitignore"
    static let globalGitignore = """
        .DS_Store
        """
    static let globalGitName = "Hal Lee"
    static let globalGitEmail = "hal@lee.me"

    /// Clone location for git repos
    static let codeLocation = home + "/Code"

    /// Repo containing font files to install
    static let fontsRepo = "git@github.com:hallee/fonts.git"

    /// Repo containing `Installed Packages` and `Packages` for Sublime Text
    static let sublimeSettingsRepo = "git@github.com:hallee/sublime-settings.git"
}
