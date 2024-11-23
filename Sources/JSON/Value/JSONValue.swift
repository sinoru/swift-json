//
//  JSON+Value.swift
//
//
//  Created by Jaehong Kang on 8/12/23.
//

#if !hasFeature(Embedded)
#if canImport(FoundationEssentials)
@_exported import struct FoundationEssentials.Decimal
#else
@_exported import struct Foundation.Decimal
#endif
#endif

import JSONNumber

extension JSON {
    /// This type represents value in JSON, which can be as a single JSON value, can be used in JSON array, or can be used as JSON object value.
    public enum Value: Sendable, Equatable, Hashable {
        /// The value is object which is in associated value.
        case object(Object)
        /// The value is array which is in associated value.
        case array(Array)
        /// The value is string which is in associated value.
        case string(String)
        /// The value is number which is in associated value.
        case number(Number)
        /// The value is bool which is in associated value.
        case bool(Bool)
        /// The value is null.
        case null
    }
}
