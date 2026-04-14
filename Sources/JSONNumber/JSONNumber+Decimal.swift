//
//  JSONNumber+Decimal.swift
//  swift-json
//
//  Created by Jaehong Kang on 11/18/24.
//

#if canImport(FoundationEssentials)
@_exported import struct FoundationEssentials.Decimal
#elseif canImport(Foundation)
@_exported import struct Foundation.Decimal
#endif

#if canImport(Foundation)
extension JSONNumber {
    public var decimal: Decimal {
        let sign: FloatingPointSign = significand >= 0 ? .plus : .minus

        return Decimal(
            sign: sign,
            exponent: exponent,
            significand: Decimal(string: significand.magnitude.description) ?? 0
        )
    }

    public init(_ value: Decimal) {
        guard !value.isZero else {
            self.init(significand: 0, exponent: 0)
            return
        }

        // Decimal's internal mantissa is UInt128 (128-bit unsigned).
        // Int128 (signed) covers all but the top half of that range.
        // For significands exceeding Int128.max, truncate least significant
        // digit(s) — at most 1 in practice — losing minimal precision.
        var significandString = value.significand.description
        var exponentAdjust = 0
        while Int128(significandString) == nil {
            significandString = String(significandString.dropLast())
            exponentAdjust += 1
        }
        let mag = Int128(significandString)!
        let signed: Int128 = value.sign == .minus ? -mag : mag
        self.init(significand: signed, exponent: value.exponent + exponentAdjust)
    }
}
#endif
