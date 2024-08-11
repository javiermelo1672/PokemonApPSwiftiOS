//
//  DetailView.swift
//  PokemonApi
//
//  Created by Javier Duvan Hospital Melo on 11/08/24.
//

import SwiftUI
import HomeViewComponent

struct DetailView: View {
    
    @StateObject var detailHomeViewModel: DetailHomeViewModel
    
    init(pokemonSelected: PokemonModel) {
        self._detailHomeViewModel = StateObject(wrappedValue: DetailHomeViewModel(pokemonSelected: pokemonSelected))
    }
    
    
    var body: some View {
        DetailScreen<DetailHomeViewModel>()
            .environmentObject(detailHomeViewModel)
    }
}

