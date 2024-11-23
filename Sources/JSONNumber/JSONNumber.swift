//
//  JSONNumber.swift
//  swift-json
//
//  Created by Jaehong Kang on 11/18/24.
//

#if canImport(Darwin)
import Darwin
#endif

public struct JSONNumber: Sendable {
    internal struct Storage {
        enum Mantissa {
            case decimal(mantissa: UInt, mantissaLength: UInt8)
            case fraction(Double)
        }

        var significand: Int64
        var mantissa: Mantissa
    }

    internal var storage: Storage

    public var significand: Int64 {
        self.storage.significand
    }

    public var fraction: Double {
        switch storage.mantissa {
        case .decimal(let mantissa, let mantissaLength):
            Double(mantissa) * pow(-10, Double(mantissaLength))
        case .fraction(let fraction):
            fraction
        }
    }

    public init(significand: Int64, decimalMantissa: UInt, decimalMantissaLength: UInt8) {
        self.storage = .init(significand: significand, mantissa: .decimal(mantissa: decimalMantissa, mantissaLength: decimalMantissaLength))
    }

    public init(significand: Int64, fraction: Double) {
        self.storage = .init(significand: significand, mantissa: .fraction(fraction))
    }
}
