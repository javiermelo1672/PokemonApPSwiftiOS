//
//  HomeViewModel.swift
//  PokemonApi
//
//  Created by Javier Duvan Hospital Melo on 10/08/24.
//

import Foundation
import HomeViewComponent
import SwiftUI
import Combine

class HomeViewModel: HomeScreenProtocol {
    
    @Published var pokemonList: PokemonModelList?
    @Published var routeDestination: HomeRoute = .none
    @Published var isLoading: Bool = true
    @Published var showNextScreen: Bool = false
    var pokemonSelected: PokemonModel?
    private let pokemonInfoUseCase: PokemonInfoUseCase
    private var cancellables = Set<AnyCancellable>()
    
    init(pokemonInfoUseCase: PokemonInfoUseCase = PokemonInfoUseCaseImpl()) {
        self.pokemonInfoUseCase = pokemonInfoUseCase
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
            self.getPokemonList()
        })
    }
    
    deinit {
        cancellables.removeAll()
    }

    func onTapCard(pokemonSelected: PokemonModel) {
        self.pokemonSelected = pokemonSelected
        self.routeDestination = .toDetail
        self.showNextScreen.toggle()
    }
}

// MARK: - Services Bussiness Logic
extension HomeViewModel {
    private func getPokemonList() {
        self.pokemonInfoUseCase.invoke(self.pokemonList, cancellables: &cancellables, response: { [weak self] pokemonData in
            guard let self = self else { return }
            DispatchQueue.main.async {
                withAnimation {
                    self.pokemonList = pokemonData
                    self.isLoading = false
                }
            }
        })
    }
}
