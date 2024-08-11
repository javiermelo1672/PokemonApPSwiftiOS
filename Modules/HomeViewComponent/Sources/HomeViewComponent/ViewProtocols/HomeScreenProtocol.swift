//
//  File.swift
//  
//
//  Created by Javier Duvan Hospital Melo on 10/08/24.
//

import Foundation

public protocol HomeScreenProtocol: ObservableObject {
    
    var pokemonList: PokemonModelList? { get set }
    var pokemonSelected: PokemonModel? { get set }
    var routeDestination: HomeRoute { get set }
    var isLoading: Bool { get set }
    var isLoadingPagination: Bool { get set }
    var showNextScreen: Bool { get set }
    var pagination: Int { get set }
    
    func onTapCard(pokemonSelected: PokemonModel)
    func getItemsPerPagination()
}

public enum HomeRoute {
    case none
    case toDetail
}
