//
//  JSONValue+Values.swift
//
//
//  Created by Jaehong Kang on 8/12/23.
//

extension JSONValue {
    @inlinable
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
    @inlinable
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
    @inlinable
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
    @inlinable
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
    @inlinable
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
    @inlinable
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
