// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Game",
    defaultLocalization: "en",
    platforms: [.iOS(.v18), .macOS(.v13)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Game",
            targets: ["Game"]),
    ],
    dependencies: [
      .package(url: "https://github.com/hmlongco/Factory", from: "2.5.3"),
      .package(url: "https://github.com/fauzandwip/Modularization-DesignSystem-Package_Dicoding-iOSExpert", from: "1.0.0"),
      .package(path: "../Core"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "Game",
            dependencies: [
              .product(name: "Core", package: "Core"),
              .product(name: "Factory", package: "Factory"),
              .product(name: "DesignSystem", package: "Modularization-DesignSystem-Package_Dicoding-iOSExpert")
            ],
            resources: [
              .process("Localizable")
            ]
        ),
    ]
)
