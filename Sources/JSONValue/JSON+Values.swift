//
//  JSON+Values.swift
//
//
//  Created by Jaehong Kang on 8/12/23.
//

extension JSON {
    @inlinable
    public var object: Object? {
        get {
            switch self {
            case .object(let object):
                return object
            default:
                return nil
            }
        }
        set {
            if let newValue = newValue {
                self = .object(newValue)
            }
        }
    }
}

extension JSON {
    @inlinable
    public var array: Array? {
        get {
            switch self {
            case .array(let array):
                return array
            default:
                return nil
            }
        }
        set {
            if let newValue = newValue {
                self = .array(newValue)
            }
        }
    }
}

extension JSON {
    @inlinable
    public var string: String? {
        get {
            switch self {
            case .string(let string):
                return string
            default:
                return nil
            }
        }
        set {
            if let newValue = newValue {
                self = .string(newValue)
            }
        }
    }
}

extension JSON {
    @inlinable
    public var number: Number? {
        get {
            switch self {
            case .number(let number):
                return number
            default:
                return nil
            }
        }
        set {
            if let newValue = newValue {
                self = .number(newValue)
            }
        }
    }
}

extension JSON {
    @inlinable
    public var bool: Bool? {
        get {
            switch self {
            case .bool(let bool):
                return bool
            default:
                return nil
            }
        }
        set {
            if let newValue = newValue {
                self = .bool(newValue)
            }
        }
    }
}

extension JSON {
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