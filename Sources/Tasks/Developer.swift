import ArgumentParser
import Foundation

struct Developer: ParsableCommand {

	static var configuration = CommandConfiguration(
		abstract: "Set up developer and terminal tools."
	)

	func run() throws {
		print(Task.developer.description)

		createDeveloperDirectory()

		copyXcodeColorScheme()

		try Brew.install("coreutils", "zinit", "tree", "fzf", "swiftlint", "shellcheck")

		copyConfiguration()

		try installLanguages()
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
		guard let zprofile = Bundle.module.url(forResource: "zprofile", withExtension: nil) else {
			print("zprofile not found")
			return
		}
		let zprofileURL = Constants.home.appendingPathComponent(".zprofile")
		do {
			try? FileManager.default.removeItem(at: zprofileURL)
			try FileManager.default.copyItem(at: zprofile, to: zprofileURL)
			try Shell.run("chmod", "644", "~/.zprofile")
		} catch {
			print(error.localizedDescription)
		}
		do {
			try Shell.run("source", Constants.home.appendingPathComponent(".zprofile").path)
		} catch {
			print(error.localizedDescription)
		}
	}

	private func installLanguages() throws {
		try Brew.install("mise")

		for language in Language.allCases {
			try install(language: language)
		}
	}

	enum Language: String, CaseIterable, EnumerableFlag {
		case go
		case node
		case python

		var version: String {
			switch self {
			case .node: return "lts"
			default: return "latest"
			}
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
