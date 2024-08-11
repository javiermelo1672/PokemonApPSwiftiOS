//
//  File.swift
//  
//
//  Created by Javier Duvan Hospital Melo on 10/08/24.
//

import Foundation

public struct PokemonInfoModel {
    public let abilities: [Abilities]
    public let height: Int
    public let weight: Int
    public let sprites: Sprites
    public let stats: [Stats]
    
    public init(abilities: [Abilities], height: Int, weight: Int, sprites: Sprites, stats: [Stats]) {
        self.abilities = abilities
        self.height = height
        self.weight = weight
        self.sprites = sprites
        self.stats = stats
    }
}

public struct Abilities: Identifiable, Hashable {
    public let id: UUID
    public let ability: Ability?
    
    public init(id: UUID, ability: Ability?) {
        self.id = id
        self.ability = ability
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    public static func == (lhs: Abilities, rhs: Abilities) -> Bool {
        return lhs.id == rhs.id
    }
}

public struct Ability {
    public let name: String?
    
    public init(name: String?) {
        self.name = name
    }
}

public struct Sprites {
    public let bacDefault: String?
    
    public init(bacDefault: String?) {
        self.bacDefault = bacDefault
    }
}

public struct Stats: Identifiable, Hashable {
    public let id: UUID
    public let baseStat: Int?
    public let effort: Int?
    public let stat: Stat?
    
    public init(id: UUID, baseStat: Int?, effort: Int?, stat: Stat?) {
        self.id = id
        self.baseStat = baseStat
        self.effort = effort
        self.stat = stat
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    public static func == (lhs: Stats, rhs: Stats) -> Bool {
        return lhs.id == rhs.id
    }
}

public struct Stat {
    public let name: String
    
    public init(name: String) {
        self.name = name
    }
}
