//
//  JSONValue+Subscripts.swift
//
//
//  Created by Jaehong Kang on 8/12/23.
//

extension JSONValue {
    @inlinable
    public subscript(key: Object.Key) -> Object.Value? {
        get {
            self.object?[key]
        }
        set {
            var objectValue = self.object ?? [:]

            objectValue[key] = newValue

            self.object = objectValue
        }
    }

    @inlinable
    public subscript(key: Key, default defaultValue: @autoclosure () -> Value) -> Value {
        self[key] ?? defaultValue()
    }

    @inlinable
    public subscript(index: Int) -> Array.Element? {
        get {
            self.array?[index]
        }
        set {
            var arrayValue = self.array ?? []

            if let newValue = newValue {
                arrayValue[index] = newValue
            } else {
                arrayValue.remove(at: index)
            }

            self.array = arrayValue
        }
    }

    @inlinable
    public subscript(bounds: Range<Int>) -> ArraySlice<Array.Element>? {
        self.array?[bounds]
    }
}
