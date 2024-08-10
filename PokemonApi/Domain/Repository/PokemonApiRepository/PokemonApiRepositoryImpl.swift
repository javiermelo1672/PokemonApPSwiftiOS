//
//  PokemonApiRepositoryImpl.swift
//  PokemonApi
//
//  Created by Javier Duvan Hospital Melo on 10/08/24.
//

import Foundation
import NetworkComponent
import Combine

class PokemonApiRepositoryImpl: PokemonApiRepository {
    
    func getPokemons(_ baseurl: String, cancellables: inout Set<AnyCancellable>, completion: @escaping (NetworkComponent.PokemonMapper.PokemonData?) -> Void) {
        let pokemonsService = PokemonService(baseUrlString: baseurl)
        pokemonsService.getPokemonsPublisher().sink(receiveCompletion: { result in
            switch result {
            case .failure(_):
                completion(nil)
            case .finished:
                break
            }
        }, receiveValue: { pokemonsList in
            completion(pokemonsList)
        }).store(in: &cancellables)
    }
}
