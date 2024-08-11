//
//  File.swift
//  
//
//  Created by Javier Duvan Hospital Melo on 11/08/24.
//

import XCTest
import Combine
@testable import NetworkComponent

class PokemonInfoServiceTest: XCTestCase {
    
    private var cancellables = Set<AnyCancellable>()
    
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
    
    func test_getPokemonsPublisher_successfulResponse() {
        let baseUrlString = "https://example.com"
        let mockHttpClient = MockURLSession()
        mockHttpClient.mockedData = makeJSON(jsonString)
        mockHttpClient.mockedResponse = HTTPURLResponse(url: URL(string: baseUrlString)!,
                                                        statusCode: 200, httpVersion: nil, headerFields: nil)
        
        let sut = PokemonInfoService(httpClient: mockHttpClient, baseUrlString: baseUrlString)
        
        let expectation = self.expectation(description: "Publisher should finish")
        
        sut.getPokemonsPublisher()
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTFail("Expected success, but got failure with error \(error)")
                }
            }, receiveValue: { pokemons in
                XCTAssertNotNil(pokemons)
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func test_getPokemonsPublisher_networkError() {
        let baseUrlString = "https://example.com"
        let mockHttpClient = MockURLSession()
        mockHttpClient.mockedError = NSError(domain: "TestError", code: -1, userInfo: nil)
        
        let sut = PokemonInfoService(httpClient: mockHttpClient, baseUrlString: baseUrlString)
        
        let expectation = self.expectation(description: "Publisher should fail")
        
        sut.getPokemonsPublisher()
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTAssertEqual((error as NSError).domain, "TestError")
                    expectation.fulfill()
                }
            }, receiveValue: { _ in
                XCTFail("Expected failure, but got success")
            })
            .store(in: &cancellables)
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func test_getPokemonsPublisher_invalidResponse() {
        let baseUrlString = "https://example.com"
        let mockHttpClient = MockURLSession()
        let invalidData = Data("Invalid JSON".utf8)
        mockHttpClient.mockedData = invalidData
        mockHttpClient.mockedResponse = HTTPURLResponse(url: URL(string: baseUrlString)!,
                                                        statusCode: 200, httpVersion: nil, headerFields: nil)
        
        let sut = PokemonInfoService(httpClient: mockHttpClient, baseUrlString: baseUrlString)
        
        let expectation = self.expectation(description: "Publisher should fail with invalid response")
        
        sut.getPokemonsPublisher()
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTAssertNotNil(error)
                    expectation.fulfill()
                }
            }, receiveValue: { _ in
                XCTFail("Expected failure, but got success")
            })
            .store(in: &cancellables)
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
}
