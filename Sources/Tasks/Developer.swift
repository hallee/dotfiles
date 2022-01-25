import ArgumentParser
import Foundation

struct Developer: ParsableCommand {

	static var configuration = CommandConfiguration(
		abstract: "Set up developer and terminal tools.",
		subcommands: [Languages.self]
	)

	func run() throws {
		print(Task.developer.description)

		createDeveloperDirectory()

		copyXcodeColorScheme()

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

	private func copyXcodeColorScheme() {
		let colorSchemeDestinationURL = Constants.userLibrary
			.appendingPathComponent("/Developer/Xcode/UserData/FontAndColorThemes", isDirectory: true)
		guard let colorSchemeURL = Bundle.module.url(forResource: "One Dark", withExtension: "xccolortheme") else {
			return
		}

		do {
			try FileManager.default.copyItem(at: colorSchemeURL, to: colorSchemeDestinationURL)
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

}

extension Developer {

	enum Language: String, CaseIterable, EnumerableFlag {
		case deno
		case golang
		case nodejs
		case python
		case ruby
		case rust

		var plugin: String {
			switch self {
			case .deno: return "https://github.com/asdf-community/asdf-deno.git"
			case .golang: return "https://github.com/kennyp/asdf-golang.git"
			case .nodejs: return "https://github.com/asdf-vm/asdf-nodejs.git"
			case .python: return "https://github.com/danhper/asdf-python.git"
			case .ruby: return "https://github.com/asdf-vm/asdf-ruby.git"
			case .rust: return "https://github.com/asdf-community/asdf-rust.git"
			}
		}
	}

	struct Languages: ParsableCommand {

		@Flag var languages: [Language] = Language.allCases

		func run() throws {
				try Brew.install("asdf", "gnupg")

			for language in languages {
				try install(language: language)
			}
		}

		private func install(language: Language) throws {
			do {
				try Shell.run("asdf", "plugin", "add", language.rawValue, language.plugin)
			} catch {
				print(error.localizedDescription)
			}
			try Shell.run("asdf", "install", language.rawValue, "latest")
			try Shell.run("asdf", "global", language.rawValue, "latest")
		}

	}

}
