import Foundation
import SwiftShell

enum Developer {

	static func setup() throws {
		createDeveloperDirectory()
		try Brew.install("fzf", "antigen", "hub")
		copyConfiguration()
	}

	private static func createDeveloperDirectory() {
		do {
			try runAndPrint(
				"mkdir",
				"\(FileManager.default.homeDirectoryForCurrentUser.path)/\(Constants.developerDirectory)/"
			)
		} catch {
			print(error)
		}
	}

	private static func copyConfiguration() {
		guard let zshrc = Bundle.module.url(forResource: ".zshrc", withExtension: nil) else {
			 return
		}
		do {
			try FileManager.default.copyItem(at: zshrc, to: FileManager.default.homeDirectoryForCurrentUser)
		} catch {
			print(error.localizedDescription)
		}
	}

}
