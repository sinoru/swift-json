//
//  JSON+Decodable.swift
//
//
//  Created by Jaehong Kang on 8/12/23.
//

import Foundation

extension JSON: Decodable {
    @inlinable
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()

        var errors = [Error]()

        do {
            let object = try container.decode(Object.self)

            self = .object(object)
            return
        } catch {
            errors.append(error)
        }

        do {
            let array = try container.decode(Array.self)

            self = .array(array)
            return
        } catch {
            errors.append(error)
        }

        do {
            let string = try container.decode(String.self)

            self = .string(string)
            return
        } catch {
            errors.append(error)
        }

        do {
            let number = try container.decode(Number.self)

            self = .number(number)
            return
        } catch {
            errors.append(error)
        }

        do {
            let bool = try container.decode(Bool.self)

            self = .bool(bool)
            return
        } catch {
            errors.append(error)
        }

        if container.decodeNil() {
            self = .null
        } else {
            throw DecodingError.dataCorrupted(.init(codingPath: decoder.codingPath, debugDescription: errors.debugDescription, underlyingError: errors.last))
        }
    }
}
