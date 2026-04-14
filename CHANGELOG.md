# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- `JSONNumber` type for representing JSON numbers with decimal precision
- `JSONValueDecoder` for decoding `JSON.Value` into `Decodable` types
- `JSONValueCoder` module
- `null` case to `JSON.Value`
- Swift 6 support
- Swift 6.2 strict memory safety support
- Arithmetic protocol conformances for `JSONNumber` (`Comparable`, `AdditiveArithmetic`, `Numeric`, `SignedNumeric`)
- Platform requirements (macOS 15, iOS 18, tvOS 18, watchOS 11, visionOS 2)

### Changed
- Upgrade `JSONNumber` significand from `Int64` to `Int128` for ~38-digit precision
- Simplify `Decimal` conversion by removing `Double` fallback path
- Replace `JSONNumber.double`/`.decimal` properties with `Double.init(_:JSONNumber)`/`Decimal.init(_:JSONNumber)` initializers
- `JSONNumber.fraction` now returns absolute value (uses `.magnitude`)
- Restructured `JSON.Value` to use `JSONNumber` instead of raw numeric types

### Fixed
- Wrong target name

## [0.1.1] - 2024-08-17

### Added
- Documentation comments
- `JSON.docc` documentation catalog
- `swift-docc-plugin` dependency
- `.spi.yml` for Swift Package Index
- `@inlinable` annotations for performance
- Swift 5.5 support
- Additional type conformances (e.g., `Hashable`, `Equatable`)

### Changed
- Shortened type names for easier use
- Cleaned up import statements

## [0.0.5] - 2023-08-13

### Added
- `Sendable` conformance to `JSONValue`

## [0.0.4] - 2023-08-12

### Changed
- Reverted to older Swift vocabulary for compatibility

## [0.0.3] - 2023-08-12

### Added
- Convenient accessor variables for `JSONValue`
- `@inlinable` annotations

### Changed
- Separated source into multiple files

## [0.0.2] - 2023-08-12

### Added
- Writable subscript support for `JSONValue`

## [0.0.1] - 2023-08-12

### Added
- Initial implementation of `JSON` and `JSONValue` types
- `Codable` (`Encodable` / `Decodable`) support
- Literal expression support (`ExpressibleByStringLiteral`, `ExpressibleByIntegerLiteral`, etc.)
- Read-only subscript access
- CI test workflow

[Unreleased]: https://github.com/sinoru/swift-json/compare/v0.1.1...HEAD
[0.1.1]: https://github.com/sinoru/swift-json/compare/v0.0.5...v0.1.1
[0.0.5]: https://github.com/sinoru/swift-json/compare/v0.0.4...v0.0.5
[0.0.4]: https://github.com/sinoru/swift-json/compare/v0.0.3...v0.0.4
[0.0.3]: https://github.com/sinoru/swift-json/compare/v0.0.2...v0.0.3
[0.0.2]: https://github.com/sinoru/swift-json/compare/v0.0.1...v0.0.2
[0.0.1]: https://github.com/sinoru/swift-json/releases/tag/v0.0.1
