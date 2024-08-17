//
//  JSONTests+Codable.swift
//
//
//  Created by Jaehong Kang on 8/12/23.
//

import XCTest
@testable import JSONValue

extension JSONTests {
    func testCodable() throws {
        let jsonValueForEncocable: JSON = [
            "glossary": [
                "title": "example glossary",
                "GlossDiv": [
                    "title": "S",
                    "GlossList": [
                        "GlossEntry": [
                            "ID": "SGML",
                            "SortAs": "SGML",
                            "GlossTerm": "Standard Generalized Markup Language",
                            "Acronym": "SGML",
                            "Abbrev": "ISO 8879:1986",
                            "GlossDef": [
                                "para": "A meta-markup language, used to create markup languages such as DocBook.",
                                "GlossSeeAlso": ["GML", "XML"]
                            ],
                            "GlossSee": "markup"
                        ]
                    ]
                ]
            ]
        ]

        let jsonEncoder = JSONEncoder()
        let jsonDecoder = JSONDecoder()

        self.measure {
            do {
                let jsonData = try jsonEncoder.encode(jsonValueForEncocable)
                let jsonValueFromDecodable = try jsonDecoder.decode(JSON.self, from: jsonData)

                stopMeasuring()

                XCTAssertEqual(
                    jsonValueForEncocable,
                    jsonValueFromDecodable
                )
            } catch {
                XCTAssertNoThrow(error)
            }

        }
    }
}
