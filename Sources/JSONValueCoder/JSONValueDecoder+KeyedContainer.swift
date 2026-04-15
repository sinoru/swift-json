//
//  JSONValueDecoder+KeyedContainer.swift
//  swift-json
//
//  Created by Jaehong Kang on 11/23/24.
//

extension JSONValueDecoder {
    struct KeyedContainer<Key: CodingKey>: KeyedDecodingContainerProtocol, Container {
        let decoder: Decoder
        let _codingPath: CodingPath
        let jsonObject: JSON.Object

        var codingPath: [any CodingKey] {
            _codingPath.keys
        }

        var allKeys: [Key] {
            jsonObject.keys.compactMap(Key.init(stringValue:))
        }

        private func getValue(forKey key: some CodingKey) throws -> JSON.Value {
            guard let value = jsonObject[key.stringValue] else {
                throw DecodingError.keyNotFound(key, .init(
                    codingPath: self.codingPath,
                    debugDescription: "No value associated with key \(key) (\"\(key.stringValue)\")."
                ))
            }
            return value
        }

        func contains(_ key: Key) -> Bool {
            jsonObject.keys.contains(key.stringValue)
        }

        func decodeNil(forKey key: Key) throws -> Bool {
            try decodeNil(from: getValue(forKey: key))
        }

        func decode(_ type: Bool.Type, forKey key: Key) throws -> Bool {
            try decode(jsonValue: getValue(forKey: key), for: type)
        }

        func decode(_ type: String.Type, forKey key: Key) throws -> String {
            try decode(jsonValue: getValue(forKey: key), for: type)
        }

        func decode(_ type: Double.Type, forKey key: Key) throws -> Double {
            try decode(jsonValue: getValue(forKey: key), for: type)
        }

        func decode(_ type: Float.Type, forKey key: Key) throws -> Float {
            try .init(decode(Double.self, forKey: key))
        }

        func decode(_ type: Int.Type, forKey key: Key) throws -> Int {
            try .init(decode(Int64.self, forKey: key))
        }

        func decode(_ type: Int8.Type, forKey key: Key) throws -> Int8 {
            try .init(decode(Int64.self, forKey: key))
        }

        func decode(_ type: Int16.Type, forKey key: Key) throws -> Int16 {
            try .init(decode(Int64.self, forKey: key))
        }

        func decode(_ type: Int32.Type, forKey key: Key) throws -> Int32 {
            try .init(decode(Int64.self, forKey: key))
        }

        func decode(_ type: Int64.Type, forKey key: Key) throws -> Int64 {
            try decode(jsonValue: getValue(forKey: key), for: type)
        }

        func decode(_ type: UInt.Type, forKey key: Key) throws -> UInt {
            try .init(decode(Int64.self, forKey: key))
        }

        func decode(_ type: UInt8.Type, forKey key: Key) throws -> UInt8 {
            try .init(decode(Int64.self, forKey: key))
        }

        func decode(_ type: UInt16.Type, forKey key: Key) throws -> UInt16 {
            try .init(decode(Int64.self, forKey: key))
        }

        func decode(_ type: UInt32.Type, forKey key: Key) throws -> UInt32 {
            try .init(decode(Int64.self, forKey: key))
        }

        func decode(_ type: UInt64.Type, forKey key: Key) throws -> UInt64 {
            try .init(decode(Int64.self, forKey: key))
        }

        func decode<T>(_ type: T.Type, forKey key: Key) throws -> T where T : Decodable {
            try decode(jsonValue: getValue(forKey: key), for: type, with: _codingPath.appending(key))
        }

        func nestedContainer<NestedKey>(keyedBy type: NestedKey.Type, forKey key: Key) throws -> KeyedDecodingContainer<NestedKey> where NestedKey : CodingKey {
            let jsonValue = try getValue(forKey: key)

            switch jsonValue {
            case .object(let object):
                return KeyedDecodingContainer(KeyedContainer<NestedKey>(decoder: decoder, _codingPath: _codingPath.appending(key), jsonObject: object))
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

        func nestedUnkeyedContainer(forKey key: Key) throws -> any UnkeyedDecodingContainer {
            let jsonValue = try getValue(forKey: key)

            switch jsonValue {
            case .array(let array):
                return UnkeyedContainer(decoder: decoder, _codingPath: _codingPath.appending(key), jsonArray: array)
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

        func superDecoder() throws -> any Swift.Decoder {
            try superDecoder(forKey: Key(stringValue: "super")!)
        }

        func superDecoder(forKey key: Key) throws -> any Swift.Decoder {
            try _Decoder(jsonValue: getValue(forKey: key), codingPath: _codingPath.appending(key), userInfo: decoder.userInfo)
        }
    }
}
