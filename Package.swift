// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "swift-multipart-formdata",
    products: [
        .library(
            name: "MultipartFormData",
            targets: ["MultipartFormData"]),
    ],
    targets: [
        .target(
            name: "MultipartFormData",
            dependencies: []),
        .testTarget(
            name: "MultipartFormDataTests",
            dependencies: ["MultipartFormData"]),
    ]
)
