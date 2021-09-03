// swift-tools-version:5.3
import PackageDescription

let package = Package(
	name: "dotfiles",
	platforms: [
		.macOS(.v11)
	],
	products: [
		.executable(name: "dotfiles", targets: ["Dotfiles"])
	],
	dependencies: [
		.package(url: "https://github.com/apple/swift-argument-parser", from: "0.4.4"),
		.package(url: "https://github.com/kareman/SwiftShell", from: "5.1.0")
	],
	targets: [
		.target(name: "Dotfiles",
			dependencies: [
				.product(name: "ArgumentParser", package: "swift-argument-parser"),
				.product(name: "SwiftShell", package: "SwiftShell")
			],
			path: "Sources"
		)
	]
)
