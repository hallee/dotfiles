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
        .package(url: "https://github.com/tuist/shell", from: "2.1.2"),
        .package(url: "https://github.com/mxcl/PromiseKit", from: "7.0.0-alpha"),
        .package(url: "https://github.com/vapor/console-kit", from: "4.0.0-alpha")
    ],
    targets: [
        .target(name: "Dotfiles",
                dependencies: ["Shell", "ConsoleKit", "PromiseKit"],
                path: "Sources")
    ]
)
