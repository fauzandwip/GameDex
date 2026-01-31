// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Profile",
    defaultLocalization: "en",
    platforms: [.iOS(.v18), .macOS(.v13)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Profile",
            targets: ["Profile"]),
    ],
    dependencies: [
      .package(url: "https://github.com/hmlongco/Factory", from: "2.5.3"),
      .package(path: "../Core"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "Profile",
            dependencies: [
              .product(name: "Core", package: "Core"),
              .product(name: "Factory", package: "Factory")
            ],
            resources: [
              .process("Localizable")
            ]
        ),

    ]
)
