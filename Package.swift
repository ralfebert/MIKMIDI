// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MIKMIDI",
    products: [
        .library(name: "MIKMIDI", targets: ["MIKMIDI"]),
    ],
    dependencies: [
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        .target(name: "MIKMIDI", dependencies: [], path: "Source", publicHeadersPath: "."),
    ]
)
