import Foundation

enum Constants {

	static let defaultGitBranchName = "main"
	static let developerDirectory = "Developer"
	static let editorCommand = "nova"
	static let excludesFile = home.appendingPathComponent(".gitignore")
	static let gitIgnore = """
		# macOS

		.DS_Store
		.Spotlight-V100
		.Trashes

		# Linux

		.Trash-*
		.nfs*

		# Windows

		Thumbs.db
		"""
	static let email = "hal@lee.me"
	static let name = "Hal Lee"

	static var home: URL {
		FileManager.default.homeDirectoryForCurrentUser
	}

	static var developerURL: URL {
		home.appendingPathComponent(developerDirectory, isDirectory: true)
	}

	static var userLibrary: URL {
		home.appendingPathComponent("Library", isDirectory: true)
	}

	static var userPreferences: URL {
		userLibrary.appendingPathComponent("Preferences", isDirectory: true)
	}

}
