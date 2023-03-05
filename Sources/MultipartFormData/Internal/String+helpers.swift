//
//  String+helpers.swift
//  swift-multipart-formdata
//
//  Created by Felix Herrmann on 30.12.21.
//

extension String {
    internal init(_ staticString: StaticString) {
        self = staticString.withUTF8Buffer { String(decoding: $0, as: UTF8.self) }
    }
}
