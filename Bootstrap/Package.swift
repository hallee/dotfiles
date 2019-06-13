// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "Bootstrap",
    platforms: [
        .macOS(.v10_12)
    ],
    products: [
        .executable(name: "Bootstrap", targets: ["Bootstrap"])
    ],
    dependencies: [
        .package(url: "https://github.com/vapor/console-kit", .upToNextMajor(from: "4.0.0-alpha"))
    ],
    targets: [
        .target(name: "Bootstrap", dependencies: ["ConsoleKit"], path: "Sources")
    ]
)
