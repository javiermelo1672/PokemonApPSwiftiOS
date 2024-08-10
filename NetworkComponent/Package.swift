// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "NetworkComponent",
    defaultLocalization: "es-419",
    platforms: [.iOS(.v16)],
    products: [
        .library(
            name: "NetworkComponent",
            targets: ["NetworkComponent"]),
    ],
    targets: [
        .target(
            name: "NetworkComponent"),
        .testTarget(
            name: "NetworkComponentTests",
            dependencies: ["NetworkComponent"]),
    ]
)
