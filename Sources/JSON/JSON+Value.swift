//
//  JSON+Value.swift
//
//
//  Created by Jaehong Kang on 8/12/23.
//

#if canImport(FoundationEssentials)
@_exported import struct FoundationEssentials.Decimal
#else
@_exported import struct Foundation.Decimal
#endif

@frozen
public enum JSON { }

extension JSON {
    /// This type represents object in JSON.
    public typealias Object = Dictionary<String, Value>
    /// This type represents array in JSON.
    public typealias Array = Swift.Array<Value>
    /// This type represents number in JSON.
    public typealias Number = Decimal

    /// This type represents value in JSON, which can be as a single JSON value, can be used in JSON array, or can be used as JSON object value.
    @frozen
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
