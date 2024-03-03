// swift-tools-version:5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "swift-multipart-formdata",
    products: [
        .library(
            name: "MultipartFormData",
            targets: ["MultipartFormData"]
        ),
    ],
    targets: [
        .target(
            name: "MultipartFormData",
            resources: [.process("Resources")]
        ),
        .testTarget(
            name: "MultipartFormDataTests",
            dependencies: ["MultipartFormData"]
        ),
    ]
)
