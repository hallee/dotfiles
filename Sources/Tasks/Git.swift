import ArgumentParser

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
		try Shell.run("git", "config", "--global", "init.defaultBranch", Constants.defaultGitBranchName)
	}

}
