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
    public typealias Object = Dictionary<String, Value>
    public typealias Array = Swift.Array<Value>
    public typealias Number = Decimal


    @frozen
    public enum Value: Sendable, Equatable, Hashable {
        case object(Object)
        case array(Array)
        case string(String)
        case number(Number)
        case bool(Bool)
        case null
    }
}
