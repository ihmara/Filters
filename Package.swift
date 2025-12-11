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
        .package(url: "https://github.com/ihmara/iMetalPlugin.git", revision: "1532d4cfefa61b67da7ad378d7c1c20048aa2127"),
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
