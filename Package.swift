// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift
// required to build this package.

// PackageDescriptions contains API used in this manifest file.
import PackageDescription

// The package initializer statement.
let package = Package(
    name: "UIKitSugar",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        // Products define the executables and libraries a package produces,
        // and make them visible & usable to other packages.
        .library(
            name: "UIKitSugar",
            targets: ["UIKitSugar"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package.
        // A target can define a module or a test suite.
        // Targets can depend on other targets in this package,
        // and on products in packages this package depends on.
        .target(
            name: "UIKitSugar",
            dependencies: []),
        .testTarget(
            name: "UIKitSugarTests",
            dependencies: ["UIKitSugar"]),
    ]
)
