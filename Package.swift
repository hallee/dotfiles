// swift-tools-version:5.9
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
		.package(url: "https://github.com/apple/swift-argument-parser", from: "1.5.0")
	],
	targets: [
		.executableTarget(
			name: "Dotfiles",
			dependencies: [
				.product(name: "ArgumentParser", package: "swift-argument-parser")
			],
			path: "Sources",
			resources: [
				.process("Resources/")
			]
		)
	]
)
