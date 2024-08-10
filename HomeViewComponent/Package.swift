// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "HomeViewComponent",
    defaultLocalization: "es-419",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "HomeViewComponent",
            targets: ["HomeViewComponent"]),
    ],
    dependencies: [
        .package(url: "https://github.com/nalexn/ViewInspector.git", .upToNextMinor(from: "0.9.11"))
    ],
    targets: [
        .target(
            name: "HomeViewComponent"),
        .testTarget(
            name: "HomeViewComponentTests",
            dependencies: ["HomeViewComponent", .product(name: "ViewInspector", package: "ViewInspector")]),
    ]
)
