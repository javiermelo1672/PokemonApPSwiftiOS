//
//  DetailHomeViewModel.swift
//  PokemonApi
//
//  Created by Javier Duvan Hospital Melo on 10/08/24.
//

import Foundation
import HomeViewComponent

class DetailHomeViewModel: DetailScreenProtocol {
    
    @Published var pokemonSelected: HomeViewComponent.PokemonModel
    
    required init(pokemonSelected: HomeViewComponent.PokemonModel) {
        self.pokemonSelected = pokemonSelected
    }
}
