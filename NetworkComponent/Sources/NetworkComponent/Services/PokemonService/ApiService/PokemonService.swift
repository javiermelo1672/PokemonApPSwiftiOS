//
//  File.swift
//  
//
//  Created by Javier Duvan Hospital Melo on 10/08/24.
//

import Foundation
import Combine

public typealias ResultPokemons = AnyPublisher<[PokemonMapper.PokemonList], Error>

final public class PokemonService {
    
    private let baseURL: URL
    private var cancellable: Cancellable?
    private let httpClient: URLSession
    private let reachability: ReachabilityCheckingProtocol
    
    public init(httpClient: URLSession = URLSession.shared,
                reachability: ReachabilityCheckingProtocol = Reachability(),
                baseUrlString: String) {
        self.httpClient = httpClient
        self.reachability = reachability
        self.baseURL = URL(string: baseUrlString)!
    }
    
    public func getPokemonsPublisher() -> ResultPokemons {
        Future { [weak self] promise in
            guard let self = self else {
                promise(.failure(NSError(domain: "General Error", code: -1, userInfo: nil)))
                return
            }
            let url = PokemonEnpoint.get.url(baseURL: self.baseURL)
            var request = URLRequest(url: url, timeoutInterval: Double.infinity)
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpMethod = "GET"
            let task = self.httpClient.dataTask(with: request) { data, response, error in
                if let error = error {
                    debugPrint("error Pokemons \(error)")
                    promise(.failure(error))
                    return
                }
                guard let data = data, let response = response as? HTTPURLResponse else {
                    promise(.failure(NSError(domain: "General Error", code: -1, userInfo: nil)))
                    return
                }
                do {
                    let resultPokemons = try PokemonMapper.map(data, from: response)
                    debugPrint("resultPokemons \(resultPokemons)")
                    promise(.success(resultPokemons))
                } catch {
                    debugPrint("errorPokemons \(error)")
                    promise(.failure(error))
                }
            }
            task.resume()
        }.eraseToAnyPublisher()
    }
}

