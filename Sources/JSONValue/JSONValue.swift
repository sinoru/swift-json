//
//  JSONValue.swift
//
//
//  Created by Jaehong Kang on 8/12/23.
//

import Foundation

@frozen
public enum JSONValue {
    public typealias Object = [String: JSONValue]
    public typealias Array = [JSONValue]
    public typealias Number = Decimal

    case object(Object)
    case array(Array)
    case string(String)
    case number(Number)
    case bool(Bool)
    case null
}

extension JSONValue: Equatable { }
extension JSONValue: Hashable { }

extension JSONValue {
    public var objectValue: Object? {
        get {
            switch self {
            case .object(let object):
                return object
            default:
                return nil
            }
        }
        set {
            if let newValue {
                self = .object(newValue)
            }
        }
    }
}

extension JSONValue {
    public var arrayValue: Array? {
        get {
            switch self {
            case .array(let array):
                return array
            default:
                return nil
            }
        }
        set {
            if let newValue {
                self = .array(newValue)
            }
        }
    }
}

extension JSONValue {
    public var stringValue: String? {
        get {
            switch self {
            case .string(let string):
                return string
            default:
                return nil
            }
        }
        set {
            if let newValue {
                self = .string(newValue)
            }
        }
    }
}

extension JSONValue {
    public var numberValue: Number? {
        get {
            switch self {
            case .number(let number):
                return number
            default:
                return nil
            }
        }
        set {
            if let newValue {
                self = .number(newValue)
            }
        }
    }
}

extension JSONValue {
    public var boolValue: Bool? {
        get {
            switch self {
            case .bool(let bool):
                return bool
            default:
                return nil
            }
        }
        set {
            if let newValue {
                self = .bool(newValue)
            }
        }
    }
}

extension JSONValue {
    public var isNull: Bool {
        get {
            switch self {
            case .null:
                return true
            default:
                return false
            }
        }
        set {
            if newValue {
                self = .null
            }
        }
    }
}
