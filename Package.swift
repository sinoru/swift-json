// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "swift-json",
    platforms: [
        .macOS(.v15),
        .iOS(.v18),
        .tvOS(.v18),
        .watchOS(.v11),
        .visionOS(.v2),
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "JSON",
            targets: ["JSON"]),
        .library(
            name: "JSONValueCoder",
            targets: ["JSONValueCoder"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-docc-plugin", from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "JSON",
            dependencies: ["JSONNumber"]),
        .target(
            name: "JSONNumber"),
        .target(name: "JSONValueCoder",
            dependencies: ["JSON"]),
        .testTarget(
            name: "JSONTests",
            dependencies: ["JSON"]),
        .testTarget(
            name: "JSONNumberTests",
            dependencies: ["JSONNumber"]),
    ]
)
