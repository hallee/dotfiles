import Foundation
import SwiftShell

enum Developer {

	static func setup() {
		do {
			try runAndPrint(
				"mkdir",
				"\(FileManager.default.homeDirectoryForCurrentUser.path)/\(Constants.developerDirectory)/"
			)
		} catch {
			print(error)
		}
	}

}
