//
//  JSON+Value_Values.swift
//
//
//  Created by Jaehong Kang on 8/12/23.
//

extension JSON.Value {
    @inlinable
    public var object: JSON.Object? {
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
            } else {
                self = nil
            }
        }
    }
}

extension JSON.Value {
    @inlinable
    public var array: JSON.Array? {
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
            } else {
                self = nil
            }
        }
    }
}

extension JSON.Value {
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
            } else {
                self = nil
            }
        }
    }
}

extension JSON.Value {
    @inlinable
    public var number: JSON.Number? {
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
            } else {
                self = nil
            }
        }
    }
}

extension JSON.Value {
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
            } else {
                self = nil
            }
        }
    }
}
