# MultipartFormData

[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2FFelixHerrmann%2Fswift-multipart-formdata%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/FelixHerrmann/swift-multipart-formdata)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2FFelixHerrmann%2Fswift-multipart-formdata%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/FelixHerrmann/swift-multipart-formdata)
[![Swift](https://github.com/FelixHerrmann/swift-multipart-formdata/actions/workflows/swift.yml/badge.svg)](https://github.com/FelixHerrmann/swift-multipart-formdata/actions/workflows/swift.yml)

Build multipart/form-data type-safe in Swift. A result builder DSL is also available.


## Installation

### [Swift Package Manager](https://swift.org/package-manager/)

Add the following to the dependencies of your `Package.swift`:

```swift
.package(url: "https://github.com/FelixHerrmann/swift-multipart-formdata.git", from: "x.x.x")
```

### Xcode

Add the package to your project as shown [here](https://developer.apple.com/documentation/swift_packages/adding_package_dependencies_to_your_app).

### Manual

Download the files in the [Sources](/Sources) folder and drag them into you project.


## Example

```swift
import MultipartFormData

let boundary = try Boundary(uncheckedBoundary: "example-boundary")
let multipartFormData = try MultipartFormData(boundary: boundary) {
    Subpart {
        ContentDisposition(name: "field1")
    } body: {
        Data("value1".utf8)
    }
    try Subpart {
        ContentDisposition(name: "field2")
        ContentType(mediaType: .applicationJson)
    } body: {
        try JSONSerialization.data(withJSONObject: ["string": "abcd", "int": 1234], options: .prettyPrinted)
    }
    
    let filename = "test.png"
    let homeDirectory = FileManager.default.homeDirectoryForCurrentUser
    let fileDirectory = homeDirectory.appendingPathComponent("Desktop").appendingPathComponent(filename)
    
    if FileManager.default.fileExists(atPath: fileDirectory.path) {
        try Subpart {
            try ContentDisposition(uncheckedName: "field3", uncheckedFilename: filename)
            ContentType(mediaType: .applicationOctetStream)
        } body: {
            try Data(contentsOf: fileDirectory)
        }
    }
}

let url = URL(string: "https://example.com/example")!
let request = URLRequest(url: url, multipartFormData: multipartFormData)
let (data, response) = try await URLSession.shared.data(for: request)
```

<details>
  <summary>The generated HTTP request</summary>
  
  ```http
  POST https://example.com/example HTTP/1.1
  Content-Length: 428
  Content-Type: multipart/form-data; boundary="example-boundary"

  --example-boundary
  Content-Disposition: form-data; name="field1"

  value1
  --example-boundary
  Content-Disposition: form-data; name="field2"
  Content-Type: application/json

  {
    "string" : "abcd",
    "int" : 1234
  }
  --example-boundary
  Content-Disposition: form-data; name="field3"; filename="test.png"
  Content-Type: application/octet-stream

  <<png-data>>
  --example-boundary--
  ```
</details>

## Documentation

For a detailed usage description, you can check out the [documentation](https://felixherrmann.github.io/swift-multipart-formdata/documentation/multipartformdata/).

![docs](https://user-images.githubusercontent.com/42500484/161771010-453000e7-2359-47f5-af91-fdceb6052b1e.png#gh-light-mode-only)
![docs](https://user-images.githubusercontent.com/42500484/161771424-bcf542e2-9bb9-4004-956b-51c41ce787da.png#gh-dark-mode-only)

## License

MultipartFormData is available under the MIT license. See the [LICENSE](/LICENSE) file for more info.
