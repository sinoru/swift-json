//
//  JSONNumber+Conformances.swift
//  swift-json
//
//  Created by Jaehong Kang on 11/19/24.
//

extension JSONNumber: Equatable {
    public static func == (lhs: JSONNumber, rhs: JSONNumber) -> Bool {
        lhs.significand == rhs.significand && lhs.exponent == rhs.exponent
    }
}

extension JSONNumber: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(significand)
        hasher.combine(exponent)
    }
}

extension JSONNumber: CustomStringConvertible {
    @inlinable
    public var description: String {
        #if canImport(Foundation)
        Decimal(self).description
        #else
        double.description
        #endif
    }
}

extension JSONNumber: ExpressibleByIntegerLiteral {
    public typealias IntegerLiteralType = Int128

    public init(integerLiteral value: IntegerLiteralType) {
        self.init(significand: value, exponent: 0)
    }
}

extension JSONNumber: ExpressibleByFloatLiteral {
    #if canImport(Foundation)
    public typealias FloatLiteralType = Decimal.FloatLiteralType
    #else
    public typealias FloatLiteralType = Double.FloatLiteralType
    #endif

    public init(floatLiteral value: FloatLiteralType) {
        #if canImport(Foundation)
        self.init(Decimal(floatLiteral: value))
        #else
        self.init(Double(value))
        #endif
    }
}

@_unavailableInEmbedded
extension JSONNumber: Decodable {
    public init(from decoder: any Decoder) throws {
        let container = try decoder.singleValueContainer()

        #if canImport(Foundation)
        let decimal = try container.decode(Decimal.self)
        self.init(decimal)
        #else
        let double = try container.decode(Double.self)
        self.init(double)
        #endif
    }
}

@_unavailableInEmbedded
extension JSONNumber: Encodable {
    public func encode(to encoder: any Encoder) throws {
        var container = encoder.singleValueContainer()

        #if canImport(Foundation)
        try container.encode(Decimal(self))
        #else
        try container.encode(double)
        #endif
    }
}
