//
//  File.swift
//  
//
//  Created by Javier Duvan Hospital Melo on 11/08/24.
//

import XCTest
@testable import NetworkComponent

final class PokemonMapperTest: XCTestCase {
    
    let jsonString = """
        {
          "count": 1,
          "next": "",
          "previous": null,
          "results": [
            {
              "name": "one",
              "url": ""
            },
            {
              "name": "two",
              "url": ""
            }
        ]
        }
        """
    
    func testMapThrowsErrorForNon2xxStatusCodes() throws {
        
        let json = makeJSON(jsonString)
        let samples = [300, 400, 500, 600]
        try samples.forEach { code in
            XCTAssertThrowsError(
                try PokemonMapper.map(json, from: HTTPURLResponse(statusCode: code))
            )
        }
    }
    
    func testMapThrowsDecodingErrorForInvalidJSONWith200StatusCode() {
        let invalidJSON = Data("invalid json".utf8)
        XCTAssertThrowsError(
            try PokemonMapper.map(invalidJSON, from: HTTPURLResponse(statusCode: 200))
        )
    }
    
    func testMapReturnsRegisterTokenForValidJSONWith200StatusCode() throws {
        let json = makeJSON(jsonString)
        let result = try PokemonMapper.map(json, from: HTTPURLResponse(statusCode: 200))
        XCTAssertEqual(result.results.first?.name, "one")
    }
    
}

func makeJSON(_ value: String) -> Data {
    return value.data(using: .utf8)!
}

extension HTTPURLResponse {
    convenience init(statusCode: Int) {
        self.init(url: anyURL(), statusCode: statusCode, httpVersion: nil, headerFields: nil)!
    }
}

func anyURL() -> URL {
    return URL(string: "http://any_url.com")!
}
