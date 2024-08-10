//
//  File.swift
//  
//
//  Created by Javier Duvan Hospital Melo on 10/08/24.
//

import Foundation

public final class PokemonMapper {
    
    public struct PokemonData: Codable {
        public let next: String
        public let results: [PokemonList]
    }
    
    public struct PokemonList: Codable, Equatable {
        public let id: UUID
        public let name: String?
        public let url: String?
        
        enum CodingKeys: String, CodingKey {
            case name
            case url
        }
        
        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            id = UUID()
            name = try container.decodeIfPresent(String.self, forKey: .name)
            url = try container.decodeIfPresent(String.self, forKey: .url)
        }
    }
    
    static func map(_ data: Data, from response: HTTPURLResponse) throws -> PokemonData {
        switch response.statusCodeCategory {
        case .success:
            let root = try JSONDecoder()
                .decode(PokemonData.self, from: data)
            return root
        case .clientError:
            throw ApiCustomError.serverError(message: "Client Error", code: "404")
        case .serverError:
            throw ApiCustomError.serverError(message: "Server Error", code: "500")
        case .other:
            throw ApiCustomError.invalidData
        }
    }
    
}
