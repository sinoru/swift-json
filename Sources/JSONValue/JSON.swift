//
//  JSON.swift
//
//
//  Created by Jaehong Kang on 8/12/23.
//

import Foundation

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
