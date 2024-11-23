//
//  CodingPaths.swift
//  swift-json
//
//  Created by Jaehong Kang on 11/18/24.
//

enum CodingPath {
    case root
    indirect case keyNode(CodingKey, Self, depth: Int)
    indirect case indexNode(Int, Self, depth: Int)
}

enum SimpleCodingKey: CodingKey {
    case string(String)
    case int(Int)

    var stringValue: String {
        switch self {
        case let .string(string): return string
        case let .int(int): return int.description
        }
    }

    init?(stringValue: String) {
        self = .string(stringValue)
    }

    var intValue: Int? {
        switch self {
        case .string:
            return nil
        case .int(let int):
            return int
        }
    }

    init?(intValue: Int) {
        self = .int(intValue)
    }
}

extension CodingPath {
    var keys: [CodingKey] {
        switch self {
        case .root:
            return []
        case let .keyNode(key, parent, _):
            return parent.keys + [key]
        case let .indexNode(index, parent, _):
            return parent.keys + [SimpleCodingKey.int(index)]
        }
    }

    var depth: Int {
        switch self {
        case .root: return 0
        case .keyNode(_, _, let depth): return depth
        case .indexNode(_, _, let depth): return depth
        }
    }

    func appending(_ key: __owned (some CodingKey)?) -> Self {
        if let key {
            return .keyNode(key, self, depth: self.depth + 1)
        } else {
            return self
        }
    }

    func path(byAppending key: __owned (some CodingKey)?) -> [CodingKey] {
        if let key {
            return self.keys + [key]
        }
        return self.keys
    }

    func appending(index: __owned Int) -> Self {
        .indexNode(index, self, depth: self.depth + 1)
    }

    func path(byAppendingIndex index: __owned Int) -> [CodingKey] {
        self.keys + [SimpleCodingKey.int(index)]
    }
}
