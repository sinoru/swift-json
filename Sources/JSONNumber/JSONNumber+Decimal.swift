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

#if canImport(Darwin)
import Darwin
#endif

#if canImport(Foundation)
extension JSONNumber {
    public var decimal: Decimal {
        let sign: FloatingPointSign = storage.significand.signum() == 1 ? .plus : .minus

        switch storage.mantissa {
        case .decimal(let mantissa, let mantissaLength):
            let exponent: Int = Int(mantissaLength)

            return Decimal(
                sign: sign,
                exponent: -exponent,
                significand: Decimal(
                    sign: sign,
                    exponent: exponent,
                    significand: Decimal(storage.significand)
                ) + Decimal(mantissa)
            )
        case .fraction(let fraction):
            return Decimal(
                sign: sign,
                exponent: 0,
                significand: Decimal(Double(storage.significand) + fraction)
            )
        }
    }

    public init(_ value: Decimal) {
        let wholeValue = Int64(value.significand.description)!
        let mantissaLength = value.exponent.magnitude

        let significand = wholeValue / Int64(pow(10, Double(mantissaLength)))
        let mantissa = UInt(wholeValue.description.suffix(Int(mantissaLength)))!

        self.init(
            significand: significand,
            decimalMantissa: mantissa,
            decimalMantissaLength: UInt8(value.exponent.magnitude)
        )
    }
}
#endif
