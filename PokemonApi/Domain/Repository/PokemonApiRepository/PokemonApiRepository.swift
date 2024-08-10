//
//  PokemonApiRepository.swift
//  PokemonApi
//
//  Created by Javier Duvan Hospital Melo on 10/08/24.
//

import Foundation
import NetworkComponent
import Combine

protocol PokemonApiRepository {
    func getPokemons(_ baseurl: String, cancellables: inout Set<AnyCancellable>, completion: @escaping (NetworkComponent.PokemonMapper.PokemonData?) -> Void)
}
