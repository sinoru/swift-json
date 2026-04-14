# swift-json

[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fsinoru%2Fswift-json%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/sinoru/swift-json)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fsinoru%2Fswift-json%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/sinoru/swift-json)

**Swift JSON** is an open-source package of JSON utilities for the Swift programming language.

## Features

- Type-safe dynamic JSON representation with `JSON.Value`
- High-precision number handling with `JSONNumber` (backed by `Int128`)
- Full `Codable` support (`Encodable` / `Decodable`)
- `JSONValueDecoder` for decoding `JSON.Value` into any `Decodable` type
- Build JSON using Swift literal syntax (dictionaries, arrays, strings, numbers, booleans, `nil`)
- `Sendable` conformance for Swift 6 concurrency

## Requirements

- Swift 6.0+
- macOS 15+ / iOS 18+ / tvOS 18+ / watchOS 11+ / visionOS 2+

## Installation

Add the dependency to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/sinoru/swift-json.git", from: "0.1.1"),
]
```

Then add the modules you need to your target:

```swift
.target(
    name: "YourTarget",
    dependencies: [
        .product(name: "JSON", package: "swift-json"),
        .product(name: "JSONValueCoder", package: "swift-json"),
    ]
),
```

## Usage

### Building JSON with Literals

`JSON.Value` conforms to Swift's `ExpressibleBy*Literal` protocols, so you can construct JSON naturally:

```swift
import JSON

let value: JSON.Value = [
    "name": "Swift JSON",
    "version": 2,
    "tags": ["json", "swift", "codable"],
    "active": true,
    "metadata": nil,
]
```

### Encoding and Decoding

`JSON.Value` works directly with Foundation's `JSONEncoder` and `JSONDecoder`:

```swift
import Foundation
import JSON

// Decode JSON data into JSON.Value
let data = Data(#"{"name":"Swift","year":2014}"#.utf8)
let value = try JSONDecoder().decode(JSON.Value.self, from: data)

// Encode JSON.Value back to JSON data
let encoded = try JSONEncoder().encode(value)
```

### Accessing Values

Use subscripts and optional properties to navigate JSON structures:

```swift
let name = value["name"]?.string    // Optional("Swift")
let year = value["year"]?.number    // Optional(JSONNumber)

// With a default value
let missing = value["unknown", default: "fallback"]

// Array access
let tags: JSON.Value = ["a", "b", "c"]
let first = tags[0]?.string         // Optional("a")
```

### Precise Number Handling

`JSONNumber` uses `Int128` significand for ~38-digit decimal precision, avoiding floating-point artifacts:

```swift
import JSONNumber

let price = JSONNumber(significand: 1999, exponent: -2) // 19.99
let double = Double(price)                               // 19.99
let decimal = Decimal(price)                              // 19.99
```

### Decoding JSON.Value into Swift Types

Use `JSONValueDecoder` to decode a `JSON.Value` into any `Decodable` type:

```swift
import JSON
import JSONValueCoder

struct User: Decodable {
    let name: String
    let age: Int
}

let json: JSON.Value = ["name": "Jaehong", "age": 30]
let user = try JSONValueDecoder().decode(User.self, from: json)
```

## Modules

| Module | Description |
|---|---|
| `JSON` | Core types: `JSON.Value`, `JSON.Object`, `JSON.Array`, `JSON.Number` |
| `JSONValueCoder` | `JSONValueDecoder` for decoding `JSON.Value` into `Decodable` types |

## Documentation

Full API documentation is available on [Swift Package Index](https://swiftpackageindex.com/sinoru/swift-json/develop/documentation/json).

## License

This project is licensed under the Apache License 2.0. See [LICENSE](LICENSE) for details.
