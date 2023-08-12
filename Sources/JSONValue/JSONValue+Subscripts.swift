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
            self.objectValue?[key]
        }
        set {
            var objectValue = self.objectValue ?? [:]

            objectValue[key] = newValue

            self.objectValue = objectValue
        }
    }

    @inlinable
    public subscript(key: Key, default defaultValue: @autoclosure () -> Value) -> Value {
        self[key] ?? defaultValue()
    }

    @inlinable
    public subscript(index: Int) -> Array.Element? {
        get {
            self.arrayValue?[index]
        }
        set {
            var arrayValue = self.arrayValue ?? []

            if let newValue = newValue {
                arrayValue[index] = newValue
            } else {
                arrayValue.remove(at: index)
            }

            self.arrayValue = arrayValue
        }
    }

    @inlinable
    public subscript(bounds: Range<Int>) -> ArraySlice<Array.Element>? {
        self.arrayValue?[bounds]
    }
}
