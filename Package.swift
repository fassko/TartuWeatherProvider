// swift-tools-version:4.2

import PackageDescription

let package = Package(
    name: "TartuWeatherProvider",
    products: [
        .library(
            name: "TartuWeatherProvider",
            targets: ["TartuWeatherProvider"])
    ],
    dependencies: [
        .package(url: "https://github.com/scinfu/SwiftSoup.git", from: "1.7.5")
    ],
    targets: [
        .target(
            name: "TartuWeatherProvider",
            dependencies: ["SwiftSoup"],
            path: "Sources")
    ]
)
