//
//  File.swift
//  
//
//  Created by Javier Duvan Hospital Melo on 10/08/24.
//

import Foundation

public final class PokemonMapper {
    
    public struct PokemonData: Codable {
        let next: String
        let results: [PokemonList]
    }
    
    public struct PokemonList: Codable, Equatable {
        var id: UUID = UUID()
        let name: String
        let url: String
    }
    
    static func map(_ data: Data, from response: HTTPURLResponse) throws -> [PokemonList] {
        switch response.statusCodeCategory {
        case .success:
            let root = try JSONDecoder()
                .decode(PokemonData.self, from: data)
            return root.results
        case .clientError:
            throw ApiCustomError.serverError(message: "Client Error", code: "404")
        case .serverError:
            throw ApiCustomError.serverError(message: "Server Error", code: "500")
        case .other:
            throw ApiCustomError.invalidData
        }
    }
    
}
