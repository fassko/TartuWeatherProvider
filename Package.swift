// swift-tools-version:4.0

import PackageDescription

let package = Package(
    name: "TartuWeatherProvider",
    products: [
        .library(
            name: "TartuWeatherProvider",
            targets: ["TartuWeatherProvider"])
    ],
    dependencies: [
        .package(url: "https://github.com/scinfu/SwiftSoup.git", from: "1.6.2")
    ],
    targets: [
        .target(
            name: "TartuWeatherProvider",
            dependencies: ["SwiftSoup"],
            path: "Sources")
    ]
)
