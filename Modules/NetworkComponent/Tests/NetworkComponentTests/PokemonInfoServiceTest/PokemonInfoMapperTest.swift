//
//  File.swift
//  
//
//  Created by Javier Duvan Hospital Melo on 11/08/24.
//

import XCTest
@testable import NetworkComponent

final class PokemonInfoMapperTest: XCTestCase {
    
    let jsonString = """
        {
          "abilities": [
            {
              "ability": {
                "name": "overgrow",
                "url": ""
              }
            }
          ],
          "height": 10,
          "weight": 130,
          "sprites": {
                "back_default": "example"
           },
           "stats": [
                {
                    "base_stat": 60,
                    "effort": 0,
                    "stat": {
                        "name": "hp"
                    }
                }
            ]
        }
        """
    
    func testMapThrowsErrorForNon2xxStatusCodes() throws {
        
        let json = makeJSON(jsonString)
        let samples = [300, 400, 500, 600]
        try samples.forEach { code in
            XCTAssertThrowsError(
                try PokemonInfoMapper.map(json, from: HTTPURLResponse(statusCode: code))
            )
        }
    }
    
    func testMapThrowsDecodingErrorForInvalidJSONWith200StatusCode() {
        let invalidJSON = Data("invalid json".utf8)
        XCTAssertThrowsError(
            try PokemonInfoMapper.map(invalidJSON, from: HTTPURLResponse(statusCode: 200))
        )
    }
    
    func testMapReturnsRegisterTokenForValidJSONWith200StatusCode() throws {
        let json = makeJSON(jsonString)
        let result = try PokemonInfoMapper.map(json, from: HTTPURLResponse(statusCode: 200))
        XCTAssertEqual(result.stats.first?.base_stat, 60)
    }
    
}
