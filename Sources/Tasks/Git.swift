import ArgumentParser
import Foundation

struct Git: ParsableCommand {

	static var configuration = CommandConfiguration(
		abstract: "Install Homebrew git and configure global settings."
	)

	func run() throws {
		print(Task.git.description)

		try Brew.install("git")
		try Shell.run("git", "config", "--global", "user.email", Constants.email)
		try Shell.run("git", "config", "--global", "user.name", Constants.name)
		try Shell.run("git", "config", "--global", "core.editor", Constants.editorCommand)
		try Shell.run("git", "config", "--global", "core.excludesfile", Constants.excludesFile.path)
		try Shell.run("git", "config", "--global", "init.defaultBranch", Constants.defaultGitBranchName)
		try Shell.run("git", "config", "--global", "url.\"git@github.com:\".insteadOf", "https://github.com/")
		FileManager.default.createFile(atPath: Constants.excludesFile.path, contents: Data(Constants.gitIgnore.utf8))
	}

}
