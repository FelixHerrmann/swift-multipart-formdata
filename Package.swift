// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

#if swift(>=5.6) && os(macOS)
let dependencies: [Package.Dependency] = [
	.package(url: "https://github.com/apple/swift-docc-plugin", from: "1.0.0"),
]
#else
let dependencies: [Package.Dependency] = []
#endif

let package = Package(
    name: "swift-multipart-formdata",
    products: [
        .library(
            name: "MultipartFormData",
            targets: ["MultipartFormData"]),
    ],
	dependencies: dependencies,
    targets: [
        .target(
            name: "MultipartFormData",
            dependencies: []),
        .testTarget(
            name: "MultipartFormDataTests",
            dependencies: ["MultipartFormData"]),
    ]
)
