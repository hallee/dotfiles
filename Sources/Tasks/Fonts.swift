import AppKit
import ArgumentParser

struct Fonts: ParsableCommand {

	static let fontURL = Constants.developerURL.appendingPathComponent("fonts", isDirectory: true)

	static let installURL = Constants.userLibrary.appendingPathComponent("Fonts", isDirectory: true)

	func run() throws {
		print(Task.fonts.description)

		if FileManager.default.fileExists(atPath: Fonts.fontURL.path) {
			try updateFonts()
		} else {
			try downloadFonts()
		}
	}

	private func updateFonts() throws {
		do {
			try Shell.run("git", "-C", Fonts.fontURL.path, "fetch")
			try Shell.run("git", "-C", Fonts.fontURL.path, "pull")
		} catch {
			print(error.localizedDescription)
		}
		try findAllFonts().forEach { font in
			let installURL = Fonts.installURL.appendingPathComponent(font.lastPathComponent)
			if FileManager.default.fileExists(atPath: installURL.path) {
				try FileManager.default.removeItem(at: installURL)
			}
			try FileManager.default.copyItem(at: font, to: installURL)
		}
	}

	private func downloadFonts() throws {
		do {
			try Shell.run("git", "clone", "git@github.com:hallee/fonts.git", Fonts.fontURL.path)
		} catch {
			print(error.localizedDescription)
		}
		try updateFonts()
	}

	private func findAllFonts() -> [URL] {
		var fonts = [URL]()

		let searcher = FileManager.default.enumerator(
			at: Fonts.fontURL,
			includingPropertiesForKeys: [.typeIdentifierKey],
			options: [.skipsPackageDescendants, .skipsHiddenFiles]
		)
		print("Searching for fonts...")

		while let file = searcher?.nextObject() as? URL {
			guard let identifier = try? file.resourceValues(
				forKeys: [.typeIdentifierKey]
			).typeIdentifier else { continue }
			guard identifier.contains("font") else { continue }
			guard !file.path.lowercased().contains("web") else { continue }

			fonts.append(file)
		}

		return fonts
	}

}
