// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "OperationResult",
    products: [
        .library(
            name: "OperationResult",
            targets: ["OperationResult"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "OperationResult",
            dependencies: []),
        .testTarget(
            name: "OperationResultTests",
            dependencies: ["OperationResult"]),
    ]
)
