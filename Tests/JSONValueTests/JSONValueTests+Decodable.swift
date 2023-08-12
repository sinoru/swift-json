//
//  JSONValueTests+Decodable.swift
//
//
//  Created by Jaehong Kang on 8/12/23.
//

import XCTest
@testable import JSONValue

extension JSONValueTests {
    func testDecodable() throws {
        let jsonString = #"""
        {
            "glossary": {
                "title": "example glossary",
                "GlossDiv": {
                    "title": "S",
                    "GlossList": {
                        "GlossEntry": {
                            "ID": "SGML",
                            "SortAs": "SGML",
                            "GlossTerm": "Standard Generalized Markup Language",
                            "Acronym": "SGML",
                            "Abbrev": "ISO 8879:1986",
                            "GlossDef": {
                                "para": "A meta-markup language, used to create markup languages such as DocBook.",
                                "GlossSeeAlso": ["GML", "XML"]
                            },
                            "GlossSee": "markup"
                        }
                    }
                }
            }
        }
        """#

        let jsonDecoder = JSONDecoder()
        let jsonValue = try jsonDecoder.decode(JSONValue.self, from: Data(jsonString.utf8))

        XCTAssertEqual(
            jsonValue,
            [
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
        )
    }
}
