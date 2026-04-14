//
//  JSONNumberTest.swift
//  swift-json
//
//  Created by Jaehong Kang on 11/23/24.
//

import Testing
@testable import JSONNumber

struct JSONNumberTest {
    // MARK: - Decimal conversion

    @Test
    func decimal() async throws {
        let decimal = Decimal(string: "123.456")!

        let jsonNumber = JSONNumber(decimal)

        #expect(jsonNumber.decimal == decimal)
    }

    @Test
    func negativeDecimal() async throws {
        let decimal = Decimal(string: "-45.67")!
        let number = JSONNumber(decimal)
        #expect(number.decimal == decimal)
    }

    @Test
    func exponentDecimal() async throws {
        let decimal = Decimal(sign: .plus, exponent: 5, significand: 3)
        let number = JSONNumber(decimal)
        #expect(number.decimal == decimal)
    }

    // MARK: - Double conversion

    @Test
    func double() async throws {
        let double: Double = 123.456

        let jsonNumber = JSONNumber(double)

        #expect(jsonNumber.double == double)
    }

    @Test
    func negativeDouble() async throws {
        let number = JSONNumber(-3.5)
        #expect(number.double == -3.5)
    }

    // MARK: - Basic properties

    @Test
    func integerRoundTrip() async throws {
        let number = JSONNumber(significand: 42, exponent: 0)
        #expect(number.double == 42.0)
        #expect(number.significand == 42)
        #expect(number.exponent == 0)
    }

    @Test
    func largeExponent() async throws {
        let number = JSONNumber(significand: 1, exponent: 100)
        #expect(number.double == 1e100)
    }

    @Test
    func fractionProperty() async throws {
        let positive = JSONNumber(significand: 314, exponent: -2)
        #expect(abs(positive.fraction - 0.14) < 1e-10)

        let negative = JSONNumber(-3.5)
        #expect(abs(negative.fraction - (-0.5)) < 1e-10)
    }

    // MARK: - Normalization

    @Test
    func normalization() async throws {
        let a = JSONNumber(significand: 100, exponent: 0)
        let b = JSONNumber(significand: 1, exponent: 2)
        #expect(a == b)
        #expect(a.significand == 1)
        #expect(a.exponent == 2)
    }

    @Test
    func zeroNormalization() async throws {
        let a = JSONNumber(significand: 0, exponent: 5)
        let b = JSONNumber(significand: 0, exponent: 0)
        #expect(a == b)
        #expect(a.significand == 0)
        #expect(a.exponent == 0)
    }

    @Test
    func hashConsistency() async throws {
        let a = JSONNumber(significand: 100, exponent: 0)
        let b = JSONNumber(significand: 1, exponent: 2)
        #expect(a.hashValue == b.hashValue)
    }

    // MARK: - Comparable

    @Test
    func comparable() async throws {
        let a: JSONNumber = 1
        let b: JSONNumber = 2
        let c: JSONNumber = -3
        let d = JSONNumber(significand: 15, exponent: -1) // 1.5

        #expect(a < b)
        #expect(c < a)
        #expect(a < d)
        #expect(d < b)
    }

    // MARK: - Arithmetic

    @Test
    func addition() async throws {
        let a: JSONNumber = 1
        let b: JSONNumber = 2
        #expect(a + b == 3)

        let c = JSONNumber(significand: 1, exponent: -1)  // 0.1
        let d = JSONNumber(significand: 2, exponent: -1)  // 0.2
        #expect(c + d == JSONNumber(significand: 3, exponent: -1))
    }

    @Test
    func subtraction() async throws {
        let a: JSONNumber = 5
        let b: JSONNumber = 3
        #expect(a - b == 2)

        let c: JSONNumber = 1
        let d: JSONNumber = 3
        #expect(c - d == -2)
    }

    @Test
    func multiplication() async throws {
        let a: JSONNumber = 3
        let b: JSONNumber = 4
        #expect(a * b == 12)

        let c = JSONNumber(significand: 15, exponent: -1) // 1.5
        let d: JSONNumber = 2
        #expect(c * d == 3)
    }

    @Test
    func negation() async throws {
        let a: JSONNumber = 42
        #expect(-a == -42)
        #expect(-(-a) == 42)
    }

    @Test
    func magnitude() async throws {
        let a: JSONNumber = -42
        #expect(a.magnitude == 42)

        let b: JSONNumber = 42
        #expect(b.magnitude == 42)
    }

    @Test
    func zero() async throws {
        #expect(JSONNumber.zero == 0)
        #expect(JSONNumber.zero.significand == 0)
        #expect(JSONNumber.zero.exponent == 0)
    }

    // MARK: - Int128 range

    @Test
    func largeSignificand() async throws {
        // Verify Int128 range works
        let large = JSONNumber(significand: 99999999999999999999, exponent: 0)
        #expect(large.significand == 99999999999999999999)
    }
}
