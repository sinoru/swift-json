//
//  JSONNumber+Values.swift
//  swift-json
//
//  Created by Jaehong Kang on 11/18/24.
//

#if canImport(Darwin)
import Darwin
#endif

extension JSONNumber {
    public var double: Double {
        Double(storage.significand) + fraction
    }

    public init(_ value: Double) {
        let significand = value.rounded(.down)
        let fraction = value.magnitude - significand

        self.init(
            significand: .init(significand),
            fraction: fraction
        )
    }
}
