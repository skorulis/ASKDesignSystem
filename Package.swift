// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ASKDesignSystem",
    platforms: [
        .macOS(.v13),
        .iOS(.v16)
    ],
    products: [
        .library(
            name: "ASKDesignSystem",
            targets: ["ASKDesignSystem"]),
    ],
    dependencies: [

    ],
    targets: [
        .target(
            name: "ASKDesignSystem",
            dependencies: [],
            path: "Sources",
            resources: [.process("Resource")]
        ),
        .testTarget(
            name: "ASKDesignSystemTests",
            dependencies: ["ASKDesignSystem"]),
    ]
)
