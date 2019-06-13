// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "dotfiles",
    platforms: [
        .macOS(.v10_12)
    ],
    products: [
        .executable(name: "dotfiles", targets: ["Dotfiles"])
    ],
    dependencies: [
        .package(url: "https://github.com/vapor/console-kit", from: "4.0.0-alpha"),
        .package(url: "https://github.com/vapor/core", from: "3.0.0")
    ],
    targets: [
        .target(name: "Dotfiles",
                dependencies: ["ConsoleKit", "Core"],
                path: "Sources")
    ]
)
