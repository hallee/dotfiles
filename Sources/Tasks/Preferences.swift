import ArgumentParser
import Foundation

struct Preferences: ParsableCommand {

	static var configuration = CommandConfiguration(
		abstract: "Set macOS preferences."
	)

	func run() throws {
		print(Task.preferences.description)

		try setDockPreferences()
		try setGeneralPreferences()
		try setMenuBarPreferences()
		try setRaycastCommandSpaceShortcut()
	}

	private func setDockPreferences() throws {
		try Shell.run("defaults write com.apple.dock autohide -bool True")
		try Shell.run("defaults write com.apple.dock \"autohide-delay\" -float \"0\"")
		try Shell.run("defaults write com.apple.dock orientation -string bottom")
		try Shell.run("defaults write com.apple.dock tilesize -float 64.0")
		try Shell.run("defaults write com.apple.dock largesize -float 78.0")
		try Shell.run("defaults write com.apple.dock show-recents -bool False")
		try Shell.run("killall Dock")
	}

	private func setGeneralPreferences() throws {
		try Shell.run("defaults write NSGlobalDomain AppleInterfaceStyle -string Dark")
		try Shell.run("defaults write NSGlobalDomain AppleReduceDesktopTinting -bool True")
		try Shell.run("defaults write NSGlobalDomain AppleScrollerPagingBehavior -bool True")
		try Shell.run("defaults write NSGlobalDomain NSTableViewDefaultSizeMode -int 2")
	}

	private func setMenuBarPreferences() throws {
		try Shell.run("defaults write com.apple.controlcenter 'NSStatusItem Visible WiFi' -bool True")
		try Shell.run("defaults write com.apple.controlcenter 'NSStatusItem Visible Bluetooth' -bool True")
		try Shell.run("defaults write com.apple.controlcenter 'NSStatusItem Visible AirDrop' -bool False")
		try Shell.run("defaults write com.apple.controlcenter 'NSStatusItem Visible FocusModes' -bool False")
		try Shell.run("defaults write com.apple.controlcenter 'NSStatusItem Visible Sound' -bool True")
		try Shell.run("defaults write com.apple.controlcenter 'NSStatusItem Visible NowPlaying' -bool False")
		try Shell.run("defaults write com.apple.Siri StatusMenuVisible -bool False")
		try Shell.run("killall SystemUIServer")
	}

	private func setRaycastCommandSpaceShortcut() throws {
		try Shell.run("defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 64 '<dict><key>enabled</key><false /><key>value</key><dict><key>parameters</key><array><integer>32</integer><integer>49</integer><integer>1048576</integer></array><key>type</key><string>standard</string></dict></dict>'")
		try Shell.run("defaults write com.raycast.macos raycastGlobalHotkey -string Command-49")
	}

}
