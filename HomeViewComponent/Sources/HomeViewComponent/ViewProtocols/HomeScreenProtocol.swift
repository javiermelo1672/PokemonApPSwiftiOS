//
//  File.swift
//  
//
//  Created by Javier Duvan Hospital Melo on 10/08/24.
//

import Foundation

public protocol HomeScreenProtocol: ObservableObject {
    
    var pokemonList: [PokemonModelList] { get set }
    var pokemonSelected: PokemonModel { get set }
    var routeDestination: homeRoute { get set }
    var isLoading: Bool { get set }
    func onTapCard()
}

public enum homeRoute {
    case toDetail
}
