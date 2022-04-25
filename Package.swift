// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ShippedShield",
    platforms: [
        .iOS(.v11)
    ],
    products: [
        .library(
            name: "ShippedShield",
            targets: ["ShippedShield"])
    ],
    targets: [
        .target(
            name: "ShippedShield",
            path: "ShippedShield",
            publicHeadersPath: "")
    ]
)
