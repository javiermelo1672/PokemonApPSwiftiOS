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
    
    func getPokemons(_ baseurl: String,
                     cancellables: inout Set<AnyCancellable>,
                     completion: @escaping (NetworkComponent.PokemonMapper.PokemonData?) -> Void) {
        self.fetchData(baseurl,
                       cancellables: &cancellables,
                       service: { PokemonService(baseUrlString: $0).getPokemonsPublisher() },
                       completion: completion)
    }
    
    func getInfoPokemon(_ baseurl: String,
                        cancellables: inout Set<AnyCancellable>,
                        completion: @escaping (NetworkComponent.PokemonInfoMapper.PokemonInfoData?) -> Void) {
        self.fetchData(baseurl,
                       cancellables: &cancellables,
                       service: { PokemonInfoService(baseUrlString: $0).getPokemonsPublisher() },
                       completion: completion)
    }
}

extension PokemonApiRepositoryImpl {
    internal func fetchData<T>(_ baseurl: String,
                     cancellables: inout Set<AnyCancellable>,
                     service: (String) -> AnyPublisher<T, Error>,
                     completion: @escaping (T?) -> Void) {
        let publisher = service(baseurl)
        publisher.sink(receiveCompletion: { result in
            switch result {
            case .failure(_):
                completion(nil)
            case .finished:
                break
            }
        }, receiveValue: { data in
            completion(data)
        }).store(in: &cancellables)
    }
}
