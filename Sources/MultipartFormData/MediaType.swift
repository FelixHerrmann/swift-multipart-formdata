//
//  MediaType.swift
//  swift-multipart-formdata
//
//  Created by Felix Herrmann on 29.12.21.
//

/// A media type (also known as a **Multipurpose Internet Mail Extensions** or **MIME type**) indicates the nature and
/// format of a document, file, or assortment of bytes.
///
/// All available types are listed [here](https://www.iana.org/assignments/media-types/media-types.xhtml).
///
/// The most common once's are conveniently available through type properties.
/// These can also be extended to avoid mistakes.
public struct MediaType: Hashable {
    
    /// The type of media.
    public let type: String
    
    /// The subtype of media.
    public let subtype: String
    
    /// Creates a new ``MediaType`` object.
    /// - Parameters:
    ///   - type: The type of media.
    ///   - subtype: The subtype of media.
    public init(type: String, subtype: String) {
        self.type = type
        self.subtype = subtype
    }
}

// MARK: - Convenience Type Properties

// swiftlint:disable missing_docs
extension MediaType {
    public static let multipartFormData = MediaType(type: "multipart", subtype: "form-data")
    
    public static let textPlain = MediaType(type: "text", subtype: "plain")
    public static let textCsv = MediaType(type: "text", subtype: "csv")
    public static let textHtml = MediaType(type: "text", subtype: "html")
    public static let textCss = MediaType(type: "text", subtype: "css")
    
    public static let imageGif = MediaType(type: "image", subtype: "gif")
    public static let imagePng = MediaType(type: "image", subtype: "png")
    public static let imageJpeg = MediaType(type: "image", subtype: "jpeg")
    public static let imageBmp = MediaType(type: "image", subtype: "bmp")
    public static let imageWebp = MediaType(type: "image", subtype: "webp")
    public static let imageSvgXml = MediaType(type: "image", subtype: "svg+xml")
    
    public static let audioMidi = MediaType(type: "audio", subtype: "midi")
    public static let audioMpeg = MediaType(type: "audio", subtype: "mpeg")
    public static let audioWebm = MediaType(type: "audio", subtype: "webm")
    public static let audioOgg = MediaType(type: "audio", subtype: "ogg")
    public static let audioWav = MediaType(type: "audio", subtype: "wav")
    
    public static let videoWebm = MediaType(type: "video", subtype: "webm")
    public static let videoOgg = MediaType(type: "video", subtype: "ogg")
    
    public static let applicationOctetStream = MediaType(type: "application", subtype: "octet-stream")
    public static let applicationXml = MediaType(type: "application", subtype: "xml")
    public static let applicationJson = MediaType(type: "application", subtype: "json")
    public static let applicationJavascript = MediaType(type: "application", subtype: "javascript")
}
// swiftlint:enable missing_docs

// MARK: - Debug

extension MediaType: CustomDebugStringConvertible {
    public var debugDescription: String {
        return _text
    }
}

// MARK: - Helpers

extension MediaType {
    internal var _text: String {
        return "\(type)/\(subtype)"
    }
}
