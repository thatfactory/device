// swift-tools-version:6.4

import PackageDescription

let package = Package(
    name: "Device",
    platforms: [
        .iOS(.v26),
        .macOS(.v26),
        .tvOS(.v26),
        .watchOS(.v26)
    ],
    products: [
        .library(
            name: "Device",
            targets: ["Device"]
        )
    ],
    dependencies: [
        .package(
            url: "https://github.com/swiftlang/swift-docc-plugin",
            from: "1.4.5"
        ),
        .package(
            url: "https://github.com/thatfactory/applogger",
            from: "1.0.0"
        )
    ],
    targets: [
        .target(
            name: "Device",
            dependencies: [
                .product(
                    name: "AppLogger",
                    package: "applogger"
                ),
            ]
        ),
        .testTarget(
            name: "DeviceTests",
            dependencies: ["Device"]
        )
    ]
)
