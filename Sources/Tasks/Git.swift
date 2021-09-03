import SwiftShell

enum Git {

	static func setup() throws {
		try Brew.install("git")
		try main.runAndPrint("git", "config", "--global", "user.email", Constants.email)
		try main.runAndPrint("git", "config", "--global", "user.name", Constants.name)
		try main.runAndPrint("git", "config", "--global", "core.editor", Constants.editorCommand)
		try main.runAndPrint("git", "config", "--global", "init.defaultBranch", Constants.defaultGitBranchName)
	}

}
