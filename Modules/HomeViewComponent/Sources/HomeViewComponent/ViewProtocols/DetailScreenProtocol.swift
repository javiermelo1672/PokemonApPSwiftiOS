//
//  File.swift
//  
//
//  Created by Javier Duvan Hospital Melo on 10/08/24.
//

import Foundation

public protocol DetailScreenProtocol: ObservableObject {
    var pokemonSelected: PokemonModel { get set }
    
    init(pokemonSelected: PokemonModel)
}
