import AppKit
import ArgumentParser

struct Apps: ParsableCommand {

	func run() throws {
		print(Task.apps.description)

		for app in App.allCases {
			install(app)
			try app.configure()
		}
		try copyPreferences()
	}

	private func install(_ app: App) {
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

	private func copyPreferences() throws {
		try Bundle.module.urls(forResourcesWithExtension: "plist", subdirectory: "Preferences")?.forEach { preferenceFile in
			let existingPreferenceFileURL = Constants.userPreferences.appendingPathComponent(preferenceFile.lastPathComponent)
			try? FileManager.default.removeItem(at: existingPreferenceFileURL)
			try FileManager.default.copyItem(at: preferenceFile, to: existingPreferenceFileURL)
			print("Imported preference file: \(preferenceFile.lastPathComponent)")
		}
	}

}

enum App: String, CaseIterable {

	case batteryBuddy = "battery-buddy"
	case blender
	case github
	case iStat = "istat-menus"
	case iterm2
	case nova
	case paw
	case raycast
	case wwdc

	var url: URL {
		var applicationURL = URL(fileURLWithPath: "/Applications/")
		switch self {
		case .batteryBuddy: applicationURL.appendPathComponent("Battery Buddy")
		case .blender: applicationURL.appendPathComponent("Blender")
		case .github: applicationURL.appendPathComponent("GitHub Desktop")
		case .iStat: applicationURL.appendPathComponent("iStat Menus")
		case .iterm2: applicationURL.appendPathComponent("iTerm")
		case .nova: applicationURL.appendPathComponent("Nova")
		case .paw: applicationURL.appendPathComponent("Paw")
		case .raycast: applicationURL.appendPathComponent("Raycast")
		case .wwdc: applicationURL.appendPathComponent("WWDC")
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
			DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
				try? Shell.run("osascript -e 'tell application \"iStat Menus\" to quit'")
			}
		case .raycast:
			guard let settingsURL = Bundle.module.url(forResource: "Raycast", withExtension: "rayconfig") else {
				return
			}
			NSWorkspace.shared.open(settingsURL)
		default:
			return
		}
	}

}
