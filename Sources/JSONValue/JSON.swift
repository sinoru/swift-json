//
//  JSON.swift
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
public enum JSON: Sendable {
    public typealias Object = [String: JSON]
    public typealias Array = [JSON]
    public typealias Number = Decimal

    case object(Object)
    case array(Array)
    case string(String)
    case number(Number)
    case bool(Bool)
    case null
}

extension JSON: Equatable { }
extension JSON: Hashable { }
