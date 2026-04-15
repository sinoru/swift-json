//
//  JSONNumber+Values.swift
//  swift-json
//
//  Created by Jaehong Kang on 11/18/24.
//

#if canImport(Darwin)
import Darwin
#elseif canImport(Glibc)
import Glibc
#elseif canImport(Musl)
import Musl
#endif

extension JSONNumber {
    public var fraction: Double {
        Double(self).magnitude.truncatingRemainder(dividingBy: 1.0)
    }

    public init(_ value: Double) {
        guard value.isFinite, value != 0 else {
            self.init(significand: 0, exponent: 0)
            return
        }
        // String(Double) produces the shortest decimal representation
        // that uniquely identifies the Double value, preserving precision
        // better than Decimal(Double) which inherits IEEE 754 artifacts.
        if let parsed = JSONNumber(decimalString: String(value)) {
            self = parsed
        } else {
            self.init(significand: Int128(value), exponent: 0)
        }
    }
}

extension Double {
    public init(_ value: JSONNumber) {
        self = Double(value.significand) * pow(10.0, Double(value.exponent))
    }
}
