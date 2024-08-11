//
//  PokemonInfoUseCaseImpl.swift
//  PokemonApi
//
//  Created by Javier Duvan Hospital Melo on 10/08/24.
//

import Foundation
import Combine
import NetworkComponent
import HomeViewComponent

class PokemonInfoUseCaseImpl: PokemonInfoUseCase {
    private var pokemonApiRepository: PokemonApiRepository
    
    init(pokemonApiRepository: PokemonApiRepository = PokemonApiRepositoryImpl()) {
        self.pokemonApiRepository = pokemonApiRepository
    }
    
    func invoke(_ initialData: PokemonModelList?, cancellables: inout Set<AnyCancellable>, response: @escaping (PokemonModelList?) -> Void) {
        let isInitialRequest = initialData?.pokemonList.isEmpty ?? true
        let url = isInitialRequest ? "https://pokeapi.co/api/v2/pokemon" : initialData?.nextUrl
        guard let validUrl = url else {
            response(nil)
            return
        }
        self.pokemonApiRepository.getPokemons(validUrl, cancellables: &cancellables) { [weak self] list in
            guard let self = self else { return }
            guard let localList = list else {
                response(nil)
                return
            }
            let convertedList = self.convertPokemonNetworktoViewList(list: localList)
            if isInitialRequest {
                response(convertedList)
            } else {
                let updatedList = PokemonModelList(
                    pokemonList: initialData?.pokemonList ?? [] + convertedList.pokemonList,
                    nextUrl: localList.next)
                response(updatedList)
            }
        }
    }
    
    func invoke(_ baseurl: String, cancellables: inout Set<AnyCancellable>, completion: @escaping (HomeViewComponent.PokemonInfoModel?) -> Void) {
        self.pokemonApiRepository.getInfoPokemon(baseurl, cancellables: &cancellables, completion: { [weak self] pokemonInfo in
            guard let self = self else { return }
            guard let localPokemonData = pokemonInfo else {
                completion(nil)
                return
            }
            completion(self.convertPokemonInfoNetwork(pokemonInfo: localPokemonData))
        })
    }
}

extension PokemonInfoUseCaseImpl {
    
    internal func convertPokemonNetworktoViewList(list: PokemonMapper.PokemonData) -> PokemonModelList {
        var pokemonModel: [PokemonModel] = []
        for item in list.results {
            pokemonModel.append(PokemonModel(id: item.id.uuidString, image: item.url ?? "",
                                             labelName: item.name ?? ""))
        }
        return PokemonModelList(pokemonList: pokemonModel, nextUrl: list.next)
    }
    
    internal func convertPokemonInfoNetwork(pokemonInfo: PokemonInfoMapper.PokemonInfoData) -> PokemonInfoModel {
        var abilities: [HomeViewComponent.Abilities] = []
        var stats: [HomeViewComponent.Stats] = []
        for abilitie in pokemonInfo.abilities {
            abilities.append(Abilities(id: abilitie.id, ability: Ability(name: abilitie.ability?.name)))
        }
        for stat in pokemonInfo.stats {
            stats.append(Stats(id: stat.id, baseStat: stat.base_stat, effort: stat.effort, stat: Stat(name: stat.stat?.name ?? "")))
        }
        return PokemonInfoModel(abilities: abilities, height: pokemonInfo.height, weight: pokemonInfo.weight, sprites: Sprites(frontDefault: pokemonInfo.sprites.front_default), stats: stats)
        
    }
}
