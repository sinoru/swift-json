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
        get {
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
        set {
            switch self {
            case .object(var object):
                object[key] = newValue

                self = .object(object)
            case .array:
                fatalError()
            case .string:
                fatalError()
            case .number:
                fatalError()
            case .bool:
                fatalError()
            case .null:
                fatalError()
            }
        }
    }

    @inlinable
    public subscript(key: Key, default defaultValue: @autoclosure () -> Value) -> Value {
        self[key] ?? defaultValue()
    }

    @inlinable
    public subscript(index: Int) -> Array.Element? {
        get {
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
        set {
            switch self {
            case .object:
                fatalError()
            case .array(var array):
                if let newValue {
                    array[index] = newValue
                } else {
                    array.remove(at: index)
                }
            case .string:
                fatalError()
            case .number:
                fatalError()
            case .bool:
                fatalError()
            case .null:
                fatalError()
            }
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
