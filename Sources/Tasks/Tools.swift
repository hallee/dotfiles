import ArgumentParser
import Foundation

struct Tools: ParsableCommand {

	func run() throws {
		print(Task.tools.description)

		try Brew.install("gifski", "shellcheck")
		try installRaycastScripts()
	}

	private func installRaycastScripts() throws {
		let raycastURL = Constants.developerURL.appendingPathComponent("raycast-script-commands", isDirectory: true)
		do {
			try Shell.run("git", "clone", "git@github.com:hallee/raycast-script-commands.git", raycastURL.path)
		} catch {
			print(error.localizedDescription)
		}
		do {
			try Shell.run("git", "-C", raycastURL.path, "fetch")
			try Shell.run("git", "-C", raycastURL.path, "pull")
		} catch {
			print(error.localizedDescription)
		}
	}

}

