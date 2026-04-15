//
//  JSONNumber+Arithmetic.swift
//  swift-json
//
//  Created by Jaehong Kang on 11/18/24.
//

// MARK: - Comparable

extension JSONNumber: Comparable {
    public static func < (lhs: JSONNumber, rhs: JSONNumber) -> Bool {
        // Handle sign differences
        let lhsNeg = lhs.significand < 0
        let rhsNeg = rhs.significand < 0
        if lhsNeg != rhsNeg {
            return lhsNeg
        }

        // Same sign: align exponents and compare significands.
        // Scale the one with the larger exponent up.
        let (lhsAligned, rhsAligned) = alignedSignificands(lhs, rhs)
        return lhsAligned < rhsAligned
    }
}

// MARK: - AdditiveArithmetic

extension JSONNumber: AdditiveArithmetic {
    public static let zero = JSONNumber(significand: 0, exponent: 0)

    public static func + (lhs: JSONNumber, rhs: JSONNumber) -> JSONNumber {
        let (lhsAligned, rhsAligned, exponent) = alignedForArithmetic(lhs, rhs)
        return JSONNumber(significand: lhsAligned + rhsAligned, exponent: exponent)
    }

    public static func - (lhs: JSONNumber, rhs: JSONNumber) -> JSONNumber {
        let (lhsAligned, rhsAligned, exponent) = alignedForArithmetic(lhs, rhs)
        return JSONNumber(significand: lhsAligned - rhsAligned, exponent: exponent)
    }
}

// MARK: - Numeric

extension JSONNumber: Numeric {
    public typealias Magnitude = JSONNumber

    public var magnitude: JSONNumber {
        if significand < 0 {
            return JSONNumber(significand: -significand, exponent: exponent)
        }
        return self
    }

    public init?<T: BinaryInteger>(exactly source: T) {
        guard let value = Int128(exactly: source) else { return nil }
        self.init(significand: value, exponent: 0)
    }

    public static func * (lhs: JSONNumber, rhs: JSONNumber) -> JSONNumber {
        JSONNumber(
            significand: lhs.significand * rhs.significand,
            exponent: lhs.exponent + rhs.exponent
        )
    }

    public static func *= (lhs: inout JSONNumber, rhs: JSONNumber) {
        lhs = lhs * rhs
    }
}

// MARK: - SignedNumeric

extension JSONNumber: SignedNumeric {
    public mutating func negate() {
        self = JSONNumber(significand: -significand, exponent: exponent)
    }
}

// MARK: - Exponent alignment helpers

extension JSONNumber {
    /// Aligns two JSONNumbers to the same exponent for comparison.
    /// Returns aligned significands scaled to a common exponent.
    /// Returns nil significands if scaling would overflow Int128.
    private static func alignedSignificands(
        _ lhs: JSONNumber, _ rhs: JSONNumber
    ) -> (lhs: Int128, rhs: Int128) {
        if lhs.exponent == rhs.exponent {
            return (lhs.significand, rhs.significand)
        }

        // Use the smaller exponent as the common base.
        let diff = lhs.exponent - rhs.exponent
        if diff > 0 {
            // lhs has larger exponent — scale lhs up
            let scale = pow10(diff)
            return (lhs.significand * scale, rhs.significand)
        } else {
            // rhs has larger exponent — scale rhs up
            let scale = pow10(-diff)
            return (lhs.significand, rhs.significand * scale)
        }
    }

    /// Aligns two JSONNumbers to the same exponent for arithmetic.
    /// Returns aligned significands and the common exponent.
    private static func alignedForArithmetic(
        _ lhs: JSONNumber, _ rhs: JSONNumber
    ) -> (lhs: Int128, rhs: Int128, exponent: Int) {
        let minExp = min(lhs.exponent, rhs.exponent)
        let (lhsAligned, rhsAligned) = alignedSignificands(lhs, rhs)
        return (lhsAligned, rhsAligned, minExp)
    }

    /// Computes 10^n as Int128. Assumes n >= 0.
    private static func pow10(_ n: Int) -> Int128 {
        precondition(n >= 0)
        var result: Int128 = 1
        for _ in 0..<n {
            result *= 10
        }
        return result
    }
}
