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
			try FileManager.default.createDirectory(at: Constants.developerURL, withIntermediateDirectories: true)
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
			try? FileManager.default.createDirectory(at: colorSchemeDestinationURL, withIntermediateDirectories: true)
			try FileManager.default.copyItem(at: colorSchemeURL, to: colorSchemeDestinationURL.appendingPathComponent(colorSchemeURL.lastPathComponent))
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
		case node
		case python

		var version: String {
			switch self {
			case .node: return "lts"
			default: return "latest"
			}
		}
	}

	struct Languages: ParsableCommand {

		@Flag var languages: [Language] = Language.allCases

		func run() throws {
			try Brew.install("mise")

			for language in languages {
				try install(language: language)
			}
		}

		private func install(language: Language) throws {
			do {
				try Shell.run("mise", "use", "\(language.rawValue)@\(language.version)", "--global")
			} catch {
				print(error.localizedDescription)
			}
		}

	}

}
