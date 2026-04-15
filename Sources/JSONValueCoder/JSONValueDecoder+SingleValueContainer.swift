//
//  JSONValueDecoder+SingleValueContainer.swift
//  swift-json
//
//  Created by Jaehong Kang on 11/23/24.
//

extension JSONValueDecoder {
    struct SingleValueContainer: SingleValueDecodingContainer, Container {
        let decoder: Decoder
        let _codingPath: CodingPath
        let jsonValue: JSON.Value

        var codingPath: [any CodingKey] {
            _codingPath.keys
        }

        func decodeNil() -> Bool {
            decodeNil(from: jsonValue)
        }

        func decode(_ type: Bool.Type) throws -> Bool {
            try decode(jsonValue: jsonValue, for: type)
        }

        func decode(_ type: String.Type) throws -> String {
            try decode(jsonValue: jsonValue, for: type)
        }

        func decode(_ type: Double.Type) throws -> Double {
            try decode(jsonValue: jsonValue, for: type)
        }

        func decode(_ type: Float.Type) throws -> Float {
            try .init(decode(Double.self))
        }

        func decode(_ type: Int.Type) throws -> Int {
            try .init(decode(Int64.self))
        }

        func decode(_ type: Int8.Type) throws -> Int8 {
            try .init(decode(Int64.self))
        }

        func decode(_ type: Int16.Type) throws -> Int16 {
            try .init(decode(Int64.self))
        }

        func decode(_ type: Int32.Type) throws -> Int32 {
            try .init(decode(Int64.self))
        }

        func decode(_ type: Int64.Type) throws -> Int64 {
            try decode(jsonValue: jsonValue, for: type)
        }

        func decode(_ type: UInt.Type) throws -> UInt {
            try .init(decode(Int64.self))
        }

        func decode(_ type: UInt8.Type) throws -> UInt8 {
            try .init(decode(Int64.self))
        }

        func decode(_ type: UInt16.Type) throws -> UInt16 {
            try .init(decode(Int64.self))
        }

        func decode(_ type: UInt32.Type) throws -> UInt32 {
            try .init(decode(Int64.self))
        }

        func decode(_ type: UInt64.Type) throws -> UInt64 {
            try .init(decode(Int64.self))
        }

        func decode<T>(_ type: T.Type) throws -> T where T : Decodable {
            try decode(jsonValue: jsonValue, for: type, with: _codingPath)
        }
    }
}
