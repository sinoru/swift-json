//
//  JSONValue+Descriptions.swift
//  swift-json
//
//  Created by Jaehong Kang on 11/23/24.
//

import JSON

extension JSON.Value {
    @inlinable
    var debugDataTypeDescription: String {
        switch self {
        case .object:
            return "a dictionary"
        case .array:
            return "an array"
        case .string:
            return "a string"
        case .number:
            return "number"
        case .bool:
            return "bool"
        case .null:
            return "null"
        }
    }
}
