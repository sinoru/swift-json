//
//  JSONValue+Subscripts.swift
//
//
//  Created by Jaehong Kang on 8/12/23.
//

import Foundation

extension JSONValue {
    @inlinable
    public subscript(key: Object.Key) -> Object.Value? {
        switch self {
        case .object(let object):
            return object[key]
        case .array:
            return nil
        case .string:
            return nil
        case .number:
            return nil
        case .bool:
            return nil
        case .null:
            return nil
        }
    }

    @inlinable
    public subscript(key: Key, default defaultValue: @autoclosure () -> Value) -> Value {
        self[key] ?? defaultValue()
    }

    @inlinable
    public subscript(index: Int) -> Array.Element? {
        switch self {
        case .object:
            return nil
        case .array(let array):
            return array[index]
        case .string:
            return nil
        case .number:
            return nil
        case .bool:
            return nil
        case .null:
            return nil
        }
    }

    @inlinable
    public subscript(bounds: Range<Int>) -> ArraySlice<Array.Element>? {
        switch self {
        case .object:
            return nil
        case .array(let array):
            return array[bounds]
        case .string:
            return nil
        case .number:
            return nil
        case .bool:
            return nil
        case .null:
            return nil
        }
    }
}
