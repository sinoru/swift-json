//
//  JSON+Value_Literals.swift
//
//
//  Created by Jaehong Kang on 8/12/23.
//

extension JSON.Value: ExpressibleByDictionaryLiteral {
    public typealias Key = JSON.Object.Key
    public typealias Value = JSON.Object.Value

    @inlinable
    public init(dictionaryLiteral elements: (Key, Value)...) {
        self = .object(.init(uniqueKeysWithValues: elements))
    }
}

extension JSON.Value: ExpressibleByArrayLiteral {
    public typealias ArrayLiteralElement = JSON.Array.Element

    @inlinable
    public init(arrayLiteral elements: ArrayLiteralElement...) {
        self = .array(.init(elements))
    }
}

extension JSON.Value: ExpressibleByStringLiteral {
    public typealias StringLiteralType = String.StringLiteralType

    @inlinable
    public init(stringLiteral value: StringLiteralType) {
        self = .string(value)
    }
}

extension JSON.Value: ExpressibleByIntegerLiteral {
    public typealias IntegerLiteralType = JSON.Number.IntegerLiteralType

    @inlinable
    public init(integerLiteral value: IntegerLiteralType) {
        self = .number(.init(integerLiteral: value))
    }
}

extension JSON.Value: ExpressibleByFloatLiteral {
    public typealias FloatLiteralType = JSON.Number.FloatLiteralType

    @inlinable
    public init(floatLiteral value: JSON.Number.FloatLiteralType) {
        self = .number(.init(floatLiteral: value))
    }
}

extension JSON.Value: ExpressibleByBooleanLiteral {
    public typealias BooleanLiteralType = Bool.BooleanLiteralType

    @inlinable
    public init(booleanLiteral value: BooleanLiteralType) {
        self = .bool(.init(booleanLiteral: value))
    }
}

extension JSON.Value: ExpressibleByNilLiteral {
    @inlinable
    public init(nilLiteral: ()) {
        self = .null
    }
}
