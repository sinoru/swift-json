//
//  JSONValueDecoder+Decoder.swift
//  swift-json
//
//  Created by Jaehong Kang on 11/23/24.
//

extension JSONValueDecoder {
    class _Decoder: Decoder {
        let jsonValue: JSON.Value
        var _codingPath: CodingPath
        var codingPath: [any CodingKey] {
            _codingPath.keys
        }
        var userInfo: [CodingUserInfoKey: Any]

        init(
            jsonValue: JSON.Value,
            codingPath: CodingPath,
            userInfo: [CodingUserInfoKey : Any]
        ) {
            self.jsonValue = jsonValue
            self._codingPath = codingPath
            self.userInfo = userInfo
        }

        func container<Key>(keyedBy type: Key.Type) throws -> KeyedDecodingContainer<Key> where Key : CodingKey {
            switch jsonValue {
            case .object(let object):
                KeyedDecodingContainer(KeyedContainer(decoder: self, _codingPath: _codingPath, jsonObject: object))
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

        func unkeyedContainer() throws -> any UnkeyedDecodingContainer {
            switch jsonValue {
            case .array(let array):
                UnkeyedContainer(decoder: self, _codingPath: _codingPath, jsonArray: array)
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

        func singleValueContainer() throws -> any SingleValueDecodingContainer {
            SingleValueContainer(decoder: self, _codingPath: _codingPath, jsonValue: jsonValue)
        }
    }
}
