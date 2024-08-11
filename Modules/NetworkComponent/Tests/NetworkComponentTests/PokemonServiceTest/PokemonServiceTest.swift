//
//  File.swift
//  
//
//  Created by Javier Duvan Hospital Melo on 11/08/24.
//

import XCTest
import Combine
@testable import NetworkComponent

class PokemonServiceTests: XCTestCase {
    
    private var cancellables = Set<AnyCancellable>()
    
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
    
    func test_getPokemonsPublisher_successfulResponse() {
        let baseUrlString = "https://example.com"
        let mockHttpClient = MockURLSession()
        mockHttpClient.mockedData = makeJSON(jsonString)
        mockHttpClient.mockedResponse = HTTPURLResponse(url: URL(string: baseUrlString)!,
                                                        statusCode: 200, httpVersion: nil, headerFields: nil)
        
        let sut = PokemonService(httpClient: mockHttpClient, baseUrlString: baseUrlString)
        
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
        
        let sut = PokemonService(httpClient: mockHttpClient, baseUrlString: baseUrlString)
        
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
        
        let sut = PokemonService(httpClient: mockHttpClient, baseUrlString: baseUrlString)
        
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
    
    class MockURLSession: URLSession {
        var mockedData: Data?
        var mockedResponse: URLResponse?
        var mockedError: Error?

        override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
            let task = MockURLSessionDataTask(completionHandler: {
                completionHandler(self.mockedData, self.mockedResponse, self.mockedError)
            })
            return task
        }

        class MockURLSessionDataTask: URLSessionDataTask {
            private let completionHandler: () -> Void

            init(completionHandler: @escaping () -> Void) {
                self.completionHandler = completionHandler
            }

            override func resume() {
                completionHandler()
            }
        }
    }
}
