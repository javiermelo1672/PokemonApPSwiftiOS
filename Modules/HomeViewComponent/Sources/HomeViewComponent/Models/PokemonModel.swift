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
    
    public init(pokemonList: [PokemonModel], nextUrl: String) {
        self.pokemonList = pokemonList
        self.nextUrl = nextUrl
    }
}

public struct PokemonModel: Hashable, Identifiable {
    public let id: String
    public var image: String
    public let labelName: String
    public var pokemonInfo: PokemonInfoModel?
    
    public init(id: String, image: String, labelName: String, pokemonInfo: PokemonInfoModel? = nil) {
        self.id = id
        self.image = image
        self.labelName = labelName
        self.pokemonInfo = pokemonInfo
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    public static func == (lhs: PokemonModel, rhs: PokemonModel) -> Bool {
        return lhs.id == rhs.id
    }
}
