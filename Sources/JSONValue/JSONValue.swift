//
//  JSONValue.swift
//
//
//  Created by Jaehong Kang on 8/12/23.
//

import Foundation

@frozen
public enum JSONValue {
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
