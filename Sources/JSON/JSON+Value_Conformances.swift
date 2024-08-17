//
//  JSON+Value_Conformances.swift
//
//
//  Created by Jaehong Kang on 8/17/24.
//


extension JSON.Value: CustomStringConvertible {
    public var description: String {
        switch self {
        case .object(let object):
            return object.description
        case .array(let array):
            return array.description
        case .string(let string):
            return string.description
        case .number(let number):
            return number.description
        case .bool(let bool):
            return bool.description
        case .null:
            return ""
        }
    }
}

extension JSON.Value: CustomDebugStringConvertible {
    public var debugDescription: String {
        var result = "JSONValue("

        switch self {
        case .object(let object):
            debugPrint(object, terminator: "", to: &result)
        case .array(let array):
            debugPrint(array, terminator: "", to: &result)
        case .string(let string):
            debugPrint(string, terminator: "", to: &result)
        case .number(let number):
            debugPrint(number, terminator: "", to: &result)
        case .bool(let bool):
            debugPrint(bool, terminator: "", to: &result)
        case .null:
            return "nil"
        }

        result += ")"

        return result
    }
}
