//
//  File.swift
//  
//
//  Created by Javier Duvan Hospital Melo on 10/08/24.
//

import Foundation

public final class PokemonInfoMapper {
    public struct PokemonInfoData: Codable {
        public let abilities: [Abilities]
        public let height: Int
        public let weight: Int
        public let sprites: Sprites
        public let stats: [Stats]
    }
    
    public struct Abilities: Codable, Identifiable, Hashable {
        public let id: UUID
        public let ability: Ability?
        
        enum CodingKeys: String, CodingKey {
            case ability
        }
        
        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            id = UUID()
            ability = try container.decodeIfPresent(Ability.self, forKey: .ability)
        }
        
        public func hash(into hasher: inout Hasher) {
            hasher.combine(id)
        }
        public static func == (lhs: Abilities, rhs: Abilities) -> Bool {
            return lhs.id == rhs.id
        }
    }
    
    public struct Ability: Codable {
        public let name: String?
        
        enum CodingKeys: String, CodingKey {
            case name
        }
        
        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            name = try container.decodeIfPresent(String.self, forKey: .name)
        }
    }
    
    public struct Sprites: Codable {
        public let front_default: String?
        
        enum CodingKeys: String, CodingKey {
            case front_default
        }
        
        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            front_default = try container.decodeIfPresent(String.self, forKey: .front_default)
        }
        
    }
    
    public struct Stats: Codable, Identifiable, Hashable {
        public let id: UUID
        public let base_stat: Int?
        public let effort: Int?
        public let stat: Stat?
        
        enum CodingKeys: String, CodingKey {
            case base_stat
            case effort
            case stat
        }
        
        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            id = UUID()
            base_stat = try container.decodeIfPresent(Int.self, forKey: .base_stat)
            effort = try container.decodeIfPresent(Int.self, forKey: .effort)
            stat = try container.decodeIfPresent(Stat.self, forKey: .stat)
        }
        
        public func hash(into hasher: inout Hasher) {
            hasher.combine(id)
        }
        public static func == (lhs: Stats, rhs: Stats) -> Bool {
            return lhs.id == rhs.id
        }
    }
    
    public struct Stat: Codable {
        public let name: String
    }
    
    static func map(_ data: Data, from response: HTTPURLResponse) throws -> PokemonInfoData {
        switch response.statusCodeCategory {
        case .success:
            let root = try JSONDecoder()
                .decode(PokemonInfoData.self, from: data)
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
