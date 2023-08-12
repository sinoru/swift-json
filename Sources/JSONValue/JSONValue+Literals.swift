//
//  JSONValue+Literals.swift
//
//
//  Created by Jaehong Kang on 8/12/23.
//

import Foundation

extension JSONValue: ExpressibleByDictionaryLiteral {
    public typealias Key = Object.Key
    public typealias Value = Object.Value

    @inlinable
    public init(dictionaryLiteral elements: (Key, Value)...) {
        self = .object(.init(uniqueKeysWithValues: elements))
    }
}

extension JSONValue: ExpressibleByArrayLiteral {
    public typealias ArrayLiteralElement = Array.Element

    @inlinable
    public init(arrayLiteral elements: ArrayLiteralElement...) {
        self = .array(.init(elements))
    }
}

extension JSONValue: ExpressibleByStringLiteral {
    public typealias StringLiteralType = String.StringLiteralType

    @inlinable
    public init(stringLiteral value: StringLiteralType) {
        self = .string(value)
    }
}

extension JSONValue: ExpressibleByIntegerLiteral {
    public typealias IntegerLiteralType = Number.IntegerLiteralType

    @inlinable
    public init(integerLiteral value: IntegerLiteralType) {
        self = .number(.init(integerLiteral: value))
    }
}

extension JSONValue: ExpressibleByFloatLiteral {
    public typealias FloatLiteralType = Number.FloatLiteralType

    @inlinable
    public init(floatLiteral value: Number.FloatLiteralType) {
        self = .number(.init(floatLiteral: value))
    }
}

extension JSONValue: ExpressibleByBooleanLiteral {
    public typealias BooleanLiteralType = Bool.BooleanLiteralType

    @inlinable
    public init(booleanLiteral value: BooleanLiteralType) {
        self = .bool(.init(booleanLiteral: value))
    }
}

extension JSONValue: ExpressibleByNilLiteral {
    @inlinable
    public init(nilLiteral: ()) {
        self = .null
    }
}
