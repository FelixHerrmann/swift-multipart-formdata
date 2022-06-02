// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

var package = Package(
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

#if swift(>=5.6)
package.dependencies.append(
    .package(url: "https://github.com/apple/swift-docc-plugin", from: "1.0.0")
)
#endif
