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
        .package(url: "https://github.com/vapor/console-kit",
                 .upToNextMajor(from: "4.0.0-alpha"))
    ],
    targets: [
        .target(name: "Dotfiles", dependencies: ["ConsoleKit"], path: "Sources")
    ]
)
