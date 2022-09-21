// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ViewBoundContextMenu",
    platforms: [
      .iOS(.v13),
      .macCatalyst(.v13),
      .macOS(.v10_15)
    ],
    products: [
        .library(
            name: "ViewBoundContextMenu",
            targets: ["ViewBoundContextMenu"]),
    ],
    dependencies: [
      .package(url: "https://github.com/SwiftUIX/SwiftUIX", from: "0.1.2")
    ],
    targets: [
        .target(
            name: "ViewBoundContextMenu",
            dependencies: ["SwiftUIX"])
    ]
)
