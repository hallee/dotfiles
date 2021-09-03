import SwiftShell

enum Apps: String, CaseIterable {

	case github
	case iStat = "istat-menus"
	case iterm2
	case nova
	case paw
	case raycast

	func configure() {
		switch self {
		default:
			return
		}
	}

	static func install() {
		for app in Apps.allCases {
			do {
				try Brew.install(app.rawValue, cask: true)
			} catch {
				print(error)
			}
			app.configure()
		}
	}

}
