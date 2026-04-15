//
//  JSONValueDecoder+UnkeyedContainer.swift
//  swift-json
//
//  Created by Jaehong Kang on 11/23/24.
//

extension JSONValueDecoder {
    struct UnkeyedContainer: UnkeyedDecodingContainer, Container {
        let decoder: Decoder
        let _codingPath: CodingPath
        let jsonArray: JSON.Array

        var codingPath: [any CodingKey] {
            _codingPath.keys
        }

        var count: Int? {
            jsonArray.count
        }

        var isAtEnd: Bool {
            currentIndex >= jsonArray.count
        }

        var currentIndex: Int = 0

        private mutating func next() -> JSON.Array.Element {
            let newValue = jsonArray[currentIndex]
            currentIndex += 1
            return newValue
        }

        mutating func decodeNil() throws -> Bool {
            let jsonValue = jsonArray[currentIndex]
            if decodeNil(from: jsonValue) {
                currentIndex += 1
                return true
            }
            return false
        }

        mutating func decode(_ type: Bool.Type) throws -> Bool {
            try decode(jsonValue: next(), for: type)
        }

        mutating func decode(_ type: String.Type) throws -> String {
            try decode(jsonValue: next(), for: type)
        }

        mutating func decode(_ type: Double.Type) throws -> Double {
            try decode(jsonValue: next(), for: type)
        }

        mutating func decode(_ type: Float.Type) throws -> Float {
            try .init(decode(Double.self))
        }

        mutating func decode(_ type: Int.Type) throws -> Int {
            try .init(decode(Int64.self))
        }

        mutating func decode(_ type: Int8.Type) throws -> Int8 {
            try .init(decode(Int64.self))
        }

        mutating func decode(_ type: Int16.Type) throws -> Int16 {
            try .init(decode(Int64.self))
        }

        mutating func decode(_ type: Int32.Type) throws -> Int32 {
            try .init(decode(Int64.self))
        }

        mutating func decode(_ type: Int64.Type) throws -> Int64 {
            try decode(jsonValue: next(), for: type)
        }

        mutating func decode(_ type: UInt.Type) throws -> UInt {
            try .init(decode(Int64.self))
        }

        mutating func decode(_ type: UInt8.Type) throws -> UInt8 {
            try .init(decode(Int64.self))
        }

        mutating func decode(_ type: UInt16.Type) throws -> UInt16 {
            try .init(decode(Int64.self))
        }

        mutating func decode(_ type: UInt32.Type) throws -> UInt32 {
            try .init(decode(Int64.self))
        }

        mutating func decode(_ type: UInt64.Type) throws -> UInt64 {
            try .init(decode(Int64.self))
        }

        mutating func decode<T>(_ type: T.Type) throws -> T where T : Decodable {
            let currentIndex = currentIndex
            return try decode(jsonValue: next(), for: type, with: _codingPath.appending(index: currentIndex))
        }

        mutating func nestedContainer<NestedKey>(keyedBy type: NestedKey.Type) throws -> KeyedDecodingContainer<NestedKey> where NestedKey : CodingKey {
            let currentIndex = currentIndex
            let jsonValue = next()

            switch jsonValue {
            case .object(let object):
                return KeyedDecodingContainer(KeyedContainer<NestedKey>(decoder: decoder, _codingPath: _codingPath.appending(index: currentIndex), jsonObject: object))
            case .array, .string, .number, .bool:
                throw DecodingError.typeMismatch([String: Any].self, DecodingError.Context(
                    codingPath: self.codingPath,
                    debugDescription: "Expected to decode \([String: Any].self) but found \(jsonValue.debugDataTypeDescription) instead."
                ))
            case .null:
                throw DecodingError.valueNotFound([String: Any].self, DecodingError.Context(
                    codingPath: self.codingPath,
                    debugDescription: "Cannot get keyed decoding container -- found null value instead"
                ))
            }
        }

        mutating func nestedUnkeyedContainer() throws -> any UnkeyedDecodingContainer {
            let currentIndex = currentIndex
            let jsonValue = next()

            switch jsonValue {
            case .array(let array):
                return UnkeyedContainer(decoder: decoder, _codingPath: _codingPath.appending(index: currentIndex), jsonArray: array)
            case .object, .string, .number, .bool:
                throw DecodingError.typeMismatch([String: Any].self, DecodingError.Context(
                    codingPath: self.codingPath,
                    debugDescription: "Expected to decode \([String: Any].self) but found \(jsonValue.debugDataTypeDescription) instead."
                ))
            case .null:
                throw DecodingError.valueNotFound([String: Any].self, DecodingError.Context(
                    codingPath: self.codingPath,
                    debugDescription: "Cannot get keyed decoding container -- found null value instead"
                ))
            }
        }

        mutating func superDecoder() throws -> any Swift.Decoder {
            let currentIndex = currentIndex
            let jsonValue = next()

            return _Decoder(jsonValue: jsonValue, codingPath: _codingPath.appending(index: currentIndex), userInfo: decoder.userInfo)
        }
    }
}
