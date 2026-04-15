//
//  JSON.swift
//  swift-json
//
//  Created by Jaehong Kang on 11/23/24.
//

import JSONNumber

@frozen
public enum JSON { }

extension JSON {
    /// This type represents object in JSON.
    public typealias Object = Dictionary<String, Value>
    /// This type represents array in JSON.
    public typealias Array = Swift.Array<Value>
    /// This type represents number in JSON.
    public typealias Number = JSONNumber
}
