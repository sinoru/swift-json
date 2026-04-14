//
//  JSONNumber.swift
//  swift-json
//
//  Created by Jaehong Kang on 11/18/24.
//

public struct JSONNumber: Sendable {
    public private(set) var significand: Int128
    public private(set) var exponent: Int

    public init(significand: Int128, exponent: Int) {
        if significand == 0 {
            self.significand = 0
            self.exponent = 0
        } else {
            var s = significand
            var e = exponent
            while s % 10 == 0 {
                s /= 10
                e += 1
            }
            self.significand = s
            self.exponent = e
        }
    }
}

extension JSONNumber {
    /// Parses a decimal string representation (e.g., "3.14", "-0.005", "1e+100")
    /// into a normalized `(significand, exponent)` pair.
    internal init?(decimalString str: String) {
        var s = str[...]

        let isNegative = s.hasPrefix("-")
        if isNegative || s.hasPrefix("+") {
            s = s.dropFirst()
        }

        // Split on 'e' or 'E'
        let expPart: Int
        if let eIndex = s.firstIndex(where: { $0 == "e" || $0 == "E" }) {
            guard let e = Int(s[s.index(after: eIndex)...]) else { return nil }
            expPart = e
            s = s[..<eIndex]
        } else {
            expPart = 0
        }

        // Process mantissa part (may contain '.')
        let decimalAdjust: Int
        let digits: String
        if let dotIndex = s.firstIndex(of: ".") {
            decimalAdjust = -(s.distance(from: s.index(after: dotIndex), to: s.endIndex))
            digits = String(s[..<dotIndex]) + String(s[s.index(after: dotIndex)...])
        } else {
            decimalAdjust = 0
            digits = String(s)
        }

        guard let mag = Int128(digits) else { return nil }
        let signed = isNegative ? -mag : mag
        self.init(significand: signed, exponent: decimalAdjust + expPart)
    }
}
