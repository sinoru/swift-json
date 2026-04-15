//
//  JSONValueDecoder.swift
//  swift-json
//
//  Created by Jaehong Kang on 11/18/24.
//

public struct JSONValueDecoder {
    public init() { }

    public func decode<T>(
        _ type: T.Type,
        from value: JSON.Value
    ) throws -> T where T : Decodable {
        let decoder = _Decoder(jsonValue: value, codingPath: .root, userInfo: [:])

        return try type.init(from: decoder)
    }
}
