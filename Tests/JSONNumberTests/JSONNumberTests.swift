//
//  JSONNumberTest.swift
//  swift-json
//
//  Created by Jaehong Kang on 11/23/24.
//

import Testing
@testable import JSONNumber

struct JSONNumberTest {
    @Test
    func decimal() async throws {
        let decimal = Decimal(string: "123.456")!

        let jsonNumber = JSONNumber(decimal)

        #expect(jsonNumber.decimal == decimal)
    }

    @Test
    func double() async throws {
        let double: Double = 123.456

        let jsonNumber = JSONNumber(double)

        #expect(jsonNumber.double == double)
    }
}
