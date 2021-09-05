import ArgumentParser
import SwiftShell

struct Git: ParsableCommand {

	func run() throws {
		print(Task.git.description)

		try Brew.install("git")
		try runAndPrint("git", "config", "--global", "user.email", Constants.email)
		try runAndPrint("git", "config", "--global", "user.name", Constants.name)
		try runAndPrint("git", "config", "--global", "core.editor", Constants.editorCommand)
		try runAndPrint("git", "config", "--global", "init.defaultBranch", Constants.defaultGitBranchName)
	}

}
