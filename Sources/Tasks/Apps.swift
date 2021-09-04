import AppKit
import SwiftShell

enum Apps: String, CaseIterable {

	case blender
	case github
	case iStat = "istat-menus"
	case iterm2
	case nova
	case paw
	case raycast

	var url: URL {
		var applicationURL = URL(fileURLWithPath: "/Applications/")
		switch self {
		case .blender: applicationURL.appendPathComponent("Blender")
		case .github: applicationURL.appendPathComponent("GitHub Desktop")
		case .iStat: applicationURL.appendPathComponent("iStat Menus")
		case .iterm2: applicationURL.appendPathComponent("iTerm")
		case .nova: applicationURL.appendPathComponent("Nova")
		case .paw: applicationURL.appendPathComponent("Paw")
		case .raycast: applicationURL.appendPathComponent("Raycast")
		}
		return applicationURL.appendingPathExtension("app")
	}

	func configure() throws {
		switch self {
		case .iStat:
			guard let settingsURL = Bundle.module.url(forResource: "iStat Menus Settings", withExtension: "ismp") else {
				return
			}
			NSWorkspace.shared.open(settingsURL)
		default:
			return
		}
	}

	static func install() throws {
		for app in Apps.allCases {
			install(app)
			try app.configure()
		}
		try copyPreferences()
	}

	private static func install(_ app: Apps) {
		guard !FileManager.default.fileExists(atPath: app.url.path) else {
			print("\(app.url.path) already installed; skipping.")
			return
		}
		do {
			try Brew.install(app.rawValue, cask: true)
		} catch {
			print(error)
		}
	}

	private static func copyPreferences() throws {
		let preferencesDirectory = FileManager.default.homeDirectoryForCurrentUser.appendingPathComponent("Library/Preferences/")
		try Bundle.module.urls(forResourcesWithExtension: "plist", subdirectory: "Preferences")?.forEach { preferenceFile in
			let existingPreferenceFileURL = preferencesDirectory.appendingPathComponent(preferenceFile.lastPathComponent)
			try? FileManager.default.removeItem(at: existingPreferenceFileURL)
			try FileManager.default.copyItem(at: preferenceFile, to: existingPreferenceFileURL)
			print("Imported preference file: \(preferenceFile.lastPathComponent)")
		}
	}

}
