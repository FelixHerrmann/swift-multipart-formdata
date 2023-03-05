//
//  Data+helpers.swift
//  swift-multipart-formdata
//
//  Created by Felix Herrmann on 29.12.21.
//

import Foundation

extension Data {
    internal static let _dash = Data("--".utf8)
    internal static let _crlf = Data("\r\n".utf8)
}
