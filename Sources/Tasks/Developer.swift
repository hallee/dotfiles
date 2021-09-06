import ArgumentParser
import Foundation

struct Developer: ParsableCommand {

	func run() throws {
		print(Task.developer.description)

		createDeveloperDirectory()
		try Brew.install("fzf", "antigen", "hub", "coreutils")
		copyConfiguration()
		try installVersionedLanguages()
	}

	private func createDeveloperDirectory() {
		do {
			try Shell.run(
				"mkdir",
				"\(FileManager.default.homeDirectoryForCurrentUser.path)/\(Constants.developerDirectory)/"
			)
		} catch {
			print(error.localizedDescription)
		}
	}

	private func copyConfiguration() {
		guard let zshrc = Bundle.module.url(forResource: ".zshrc", withExtension: nil) else {
			 return
		}
		do {
			try FileManager.default.copyItem(
				at: zshrc,
				to: FileManager.default.homeDirectoryForCurrentUser.appendingPathComponent(zshrc.lastPathComponent)
			)
		} catch {
			print(error.localizedDescription)
		}
		do {
			try Shell.run("source", "\(FileManager.default.homeDirectoryForCurrentUser.path)/.zshrc")
		} catch {
			print(error.localizedDescription)
		}
	}

	private func installVersionedLanguages() throws {
		try Brew.install("asdf", "gnupg")

		// Node.js
		do {
			try Shell.run("asdf", "plugin", "add", "nodejs", "https://github.com/asdf-vm/asdf-nodejs.git")
		} catch {
			print(error.localizedDescription)
		}
		try Shell.run("asdf", "install", "nodejs", "latest")
		try Shell.run("asdf", "global", "nodejs", "latest")

		// Ruby
		do {
			try Shell.run("asdf", "plugin", "add", "ruby", "https://github.com/asdf-vm/asdf-ruby.git")
		} catch {
			print(error.localizedDescription)
		}
		try Shell.run("asdf", "install", "ruby", "latest")
		try Shell.run("asdf", "global", "ruby", "latest")

		// Rust
		do {
			try Shell.run("asdf", "plugin", "add", "rust", "https://github.com/asdf-community/asdf-rust.git")
		} catch {
			print(error.localizedDescription)
		}
		try Shell.run("asdf", "install", "rust", "latest")
		try Shell.run("asdf", "global", "rust", "latest")
	}

}
