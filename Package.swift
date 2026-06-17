// swift-tools-version:6.2

import PackageDescription

let package = Package(
    name: "Device",
    platforms: [
        .iOS(.v14),
        .macOS(.v11),
        .tvOS(.v14),
        .watchOS(.v7)
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
