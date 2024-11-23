//
//  JSONValueDecoder+Container.swift
//  swift-json
//
//  Created by Jaehong Kang on 11/23/24.
//

import Foundation

extension JSONValueDecoder {
    protocol Container {
        var decoder: Decoder { get }
        var codingPath: [any CodingKey] { get }
    }
}

extension JSONValueDecoder.Container {
    func decodeNil(from jsonValue: JSON.Value) -> Bool {
        switch jsonValue {
        case .object, .array, .string, .number, .bool:
            return false
        case .null:
            return true
        }
    }

    func decode(jsonValue: JSON.Value, for type: Bool.Type) throws -> Bool {
        switch jsonValue {
        case .object, .array, .string, .number:
            throw DecodingError.typeMismatch(type, DecodingError.Context(
                codingPath: self.codingPath,
                debugDescription: "Expected to decode \(type) but found \(jsonValue.debugDataTypeDescription) instead."
            ))
        case .bool(let bool):
            return bool
        case .null:
            throw DecodingError.valueNotFound(type, DecodingError.Context(
                codingPath: self.codingPath,
                debugDescription: "Cannot get keyed decoding container -- found null value instead"
            ))
        }
    }

    func decode(jsonValue: JSON.Value, for type: String.Type) throws -> String {
        switch jsonValue {
        case .object, .array, .number, .bool:
            throw DecodingError.typeMismatch(type, DecodingError.Context(
                codingPath: self.codingPath,
                debugDescription: "Expected to decode \(type) but found \(jsonValue.debugDataTypeDescription) instead."
            ))
        case .string(let string):
            return string
        case .null:
            throw DecodingError.valueNotFound(type, DecodingError.Context(
                codingPath: self.codingPath,
                debugDescription: "Cannot get keyed decoding container -- found null value instead"
            ))
        }
    }

    func decode(jsonValue: JSON.Value, for type: Double.Type) throws -> Double {
        switch jsonValue {
        case .object, .array, .string, .bool:
            throw DecodingError.typeMismatch(type, DecodingError.Context(
                codingPath: self.codingPath,
                debugDescription: "Expected to decode \(type) but found \(jsonValue.debugDataTypeDescription) instead."
            ))
        case .number(let number):
            return number.double
        case .null:
            throw DecodingError.valueNotFound(type, DecodingError.Context(
                codingPath: self.codingPath,
                debugDescription: "Cannot get keyed decoding container -- found null value instead"
            ))
        }
    }

    func decode(jsonValue: JSON.Value, for type: Int64.Type) throws -> Int64 {
        switch jsonValue {
        case .object, .array, .string, .bool:
            throw DecodingError.typeMismatch(type, DecodingError.Context(
                codingPath: self.codingPath,
                debugDescription: "Expected to decode \(type) but found \(jsonValue.debugDataTypeDescription) instead."
            ))
        case .number(let number):
            return number.significand
        case .null:
            throw DecodingError.valueNotFound(type, DecodingError.Context(
                codingPath: self.codingPath,
                debugDescription: "Cannot get keyed decoding container -- found null value instead"
            ))
        }
    }

    func decode<D: Decodable>(jsonValue: JSON.Value, for type: D.Type, with codingPath: CodingPath) throws -> D {
        switch type {
        case is URL.Type:
            let string = try decode(jsonValue: jsonValue, for: String.self)
            return unsafeBitCast(URL(string: string), to: D.self)
        default:
            return try D(from: JSON.ValueDecoder._Decoder(jsonValue: jsonValue, codingPath: codingPath, userInfo: decoder.userInfo))
        }
    }
}
