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
            guard let localPokemonData = pokemonData else {
                withAnimation {
                    self.isLoading = false
                }
                return
            }
            DispatchQueue.main.async {
                self.pokemonList = localPokemonData
                self.getPokemonInfo()
            }
        })
    }
    
    private func getPokemonInfo() {
        guard let localPokemonList = self.pokemonList else { return }
        var updatedPokemonList = localPokemonList
        let dispatchGroup = DispatchGroup()
        for index in updatedPokemonList.pokemonList.indices {
            dispatchGroup.enter()
            self.pokemonInfoUseCase.invoke(updatedPokemonList.pokemonList[index].image, cancellables: &cancellables) { [weak self] pokemonData in
                guard let self = self else { return }
                updatedPokemonList.pokemonList[index].image = pokemonData?.sprites.frontDefault ?? ""
                updatedPokemonList.pokemonList[index].pokemonInfo = pokemonData
                dispatchGroup.leave()
            }
        }
        dispatchGroup.notify(queue: .main) {
            self.pokemonList = updatedPokemonList
            withAnimation {
                self.isLoading = false
            }
        }
    }
}
