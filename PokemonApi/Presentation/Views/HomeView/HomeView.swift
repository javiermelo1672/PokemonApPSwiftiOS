//
//  HomeViewModel.swift
//  PokemonApi
//
//  Created by Javier Duvan Hospital Melo on 10/08/24.
//

import SwiftUI
import HomeViewComponent

struct HomeView: View {
    
    @StateObject var homeViewModel = HomeViewModel()
    
    var body: some View {
        HomeScreen<HomeViewModel>()
            .environmentObject(homeViewModel)
            .fullScreenCover(isPresented: $homeViewModel.showNextScreen, content: {
                switch homeViewModel.routeDestination {
                case .none:
                    Text("")
                case .toDetail:
                    if let pokemonS = homeViewModel.pokemonSelected {
                        DetailView(pokemonSelected: pokemonS)
                    }
                }
        })
    }
}

#Preview {
    HomeView()
}
