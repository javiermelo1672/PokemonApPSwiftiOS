//
//  File.swift
//  
//
//  Created by Javier Duvan Hospital Melo on 10/08/24.
//

import Foundation

public struct PokemonModelList {
    public var pokemonList: [PokemonModel]
    public var nextUrl: String
    public var pokemonInfo: PokemonInfoModel?
    
    public init(pokemonList: [PokemonModel], nextUrl: String, pokemonInfo: PokemonInfoModel? = nil) {
        self.pokemonList = pokemonList
        self.nextUrl = nextUrl
        self.pokemonInfo = pokemonInfo
    }
}

public struct PokemonModel: Hashable, Identifiable {
    public let id: String
    public let image: String
    public let labelName: String
    
    public init(id: String, image: String, labelName: String) {
        self.id = id
        self.image = image
        self.labelName = labelName
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    public static func == (lhs: PokemonModel, rhs: PokemonModel) -> Bool {
        return lhs.id == rhs.id
    }
}
