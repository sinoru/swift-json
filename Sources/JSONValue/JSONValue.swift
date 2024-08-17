//
//  JSONValue.swift
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
public enum JSONValue: Sendable {
    public typealias Object = [String: JSONValue]
    public typealias Array = [JSONValue]
    public typealias Number = Decimal

    case object(Object)
    case array(Array)
    case string(String)
    case number(Number)
    case bool(Bool)
    case null
}

extension JSONValue: Equatable { }
extension JSONValue: Hashable { }
