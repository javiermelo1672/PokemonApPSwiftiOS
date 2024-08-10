//
//  HomeViewModel.swift
//  PokemonApi
//
//  Created by Javier Duvan Hospital Melo on 10/08/24.
//

import Foundation
import HomeViewComponent

class HomeViewModel: HomeScreenProtocol {
    
    @Published var pokemonList: [HomeViewComponent.PokemonModel]?
    @Published var routeDestination: HomeViewComponent.HomeRoute = .none
    @Published var isLoading: Bool = true
    @Published var showNextScreen: Bool = true
    var pokemonSelected: HomeViewComponent.PokemonModel?
    
    init() {
        
    }
    
    deinit {
        self.pokemonList = nil
        self.pokemonSelected = nil
    }
    
    func onTapCard(pokemonSelected: HomeViewComponent.PokemonModel) {
        self.pokemonSelected = pokemonSelected
        self.routeDestination = .toDetail
        self.showNextScreen.toggle()
    }
}

// MARK: - Services Bussiness Logic
extension HomeViewModel {
    
}
