//
//  JSONNumber+Conformances.swift
//  swift-json
//
//  Created by Jaehong Kang on 11/19/24.
//

#if canImport(FoundationEssentials)
@_exported import struct FoundationEssentials.Decimal
#elseif canImport(Foundation)
@_exported import struct Foundation.Decimal
#endif

extension JSONNumber: Equatable {
    public static func == (lhs: JSONNumber, rhs: JSONNumber) -> Bool {
        #if canImport(Foundation)
        switch (lhs.storage.mantissa, rhs.storage.mantissa) {
        case (.decimal, _), (_, .decimal):
            return lhs.decimal == rhs.decimal
        case (.fraction, .fraction):
            return lhs.double == rhs.double
        }
        #else
        lhs.double == rhs.double
        #endif
    }
}

extension JSONNumber: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(double)
    }
}

extension JSONNumber: CustomStringConvertible {
    @inlinable
    public var description: String {
        #if canImport(Foundation)
        decimal.description
        #else
        double.description
        #endif
    }
}

extension JSONNumber: ExpressibleByIntegerLiteral {
    public typealias IntegerLiteralType = Int64

    public init(integerLiteral value: IntegerLiteralType) {
        self.init(significand: value, fraction: 0)
    }
}

extension JSONNumber: ExpressibleByFloatLiteral {
    #if canImport(Foundation)
    public typealias FloatLiteralType = Decimal.FloatLiteralType
    #else
    public typealias FloatLiteralType = Double.FloatLiteralType
    #endif

    public init(floatLiteral value: FloatLiteralType) {
        let significand = Int(value.rounded(.down))

        self.init(significand: .init(value.rounded(.down)), fraction: value - Double(significand))
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
        try container.encode(decimal)
        #else
        try container.encode(double)
        #endif
    }
}
