// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Filters",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Filters",
            targets: ["Filters"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/ihmara/iMetalPlugin.git", revision: "a859bed30b8ac9d379dca0a4f98279cd3d932cc4"),
        //.package(path: "../iMetalPlugin/"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "Filters",
            exclude: ["ThresholdPaintAlphaFilterKernel.ci.metal"],
            plugins: [.plugin(name: "iMetalPlugin", package: "iMetalPlugin")]
        )
    ]
)
