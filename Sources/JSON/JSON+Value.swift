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

@frozen
public enum JSON { }

extension JSON {
    /// This type represents object in JSON.
    public typealias Object = Dictionary<String, Value?>
    /// This type represents array in JSON.
    public typealias Array = Swift.Array<Value?>
    /// This type represents number in JSON.
    #if !hasFeature(Embedded)
    public typealias Number = Decimal
    #else
    public typealias Number = Double
    #endif

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
    }
}
