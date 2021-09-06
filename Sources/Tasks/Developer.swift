import ArgumentParser
import Foundation

struct Developer: ParsableCommand {

	func run() throws {
		print(Task.developer.description)

		createDeveloperDirectory()
		try installVersionedLanguages()
		try Brew.install("zinit", "tree", "terminal-notifier", "fzf", "hub", "coreutils")
		try? Shell.run("terminal-notifier")
		copyConfiguration()
	}

	private func createDeveloperDirectory() {
		do {
			try Shell.run(
				"mkdir",
				Constants.developerURL.path
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
				to: Constants.home.appendingPathComponent(zshrc.lastPathComponent)
			)
		} catch {
			print(error.localizedDescription)
		}
		do {
			try Shell.run("source", Constants.home.appendingPathComponent(zshrc.lastPathComponent).path)
		} catch {
			print(error.localizedDescription)
		}
	}

	private func installVersionedLanguages() throws {
		try Brew.install("asdf", "gnupg")

		// Deno
		do {
			try Shell.run("asdf", "plugin", "add", "deno", "https://github.com/asdf-community/asdf-deno.git")
		} catch {
			print(error.localizedDescription)
		}
		try Shell.run("asdf", "install", "deno", "latest")
		try Shell.run("asdf", "global", "deno", "latest")

		// Go
		do {
			try Shell.run("asdf", "plugin", "add", "golang", "https://github.com/kennyp/asdf-golang.git")
		} catch {
			print(error.localizedDescription)
		}
		try Shell.run("asdf", "install", "golang", "latest")
		try Shell.run("asdf", "global", "golang", "latest")

		// Node.js
		do {
			try Shell.run("asdf", "plugin", "add", "nodejs", "https://github.com/asdf-vm/asdf-nodejs.git")
		} catch {
			print(error.localizedDescription)
		}
		try Shell.run("asdf", "install", "nodejs", "latest")
		try Shell.run("asdf", "global", "nodejs", "latest")

		// Python
		do {
			try Shell.run("asdf", "plugin", "add", "python")
		} catch {
			print(error.localizedDescription)
		}
		try Shell.run("asdf", "install", "python", "latest")
		try Shell.run("asdf", "global", "python", "latest")

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
