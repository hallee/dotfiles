import ArgumentParser
import Foundation
import SwiftShell

struct Developer: ParsableCommand {

	func run() throws {
		print(Task.developer.description)

		createDeveloperDirectory()
		try Brew.install("fzf", "antigen", "hub")
		copyConfiguration()
	}

	private func createDeveloperDirectory() {
		do {
			try runAndPrint(
				"mkdir",
				"\(FileManager.default.homeDirectoryForCurrentUser.path)/\(Constants.developerDirectory)/"
			)
		} catch {
			print(error)
		}
	}

	private func copyConfiguration() {
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
