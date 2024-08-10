//
//  SwiftUIView.swift
//  
//
//  Created by Javier Duvan Hospital Melo on 10/08/24.
//

import SwiftUI

struct HomeScreen<Model>: View where Model: HomeScreenProtocol {
    
    @ObservedObject private var viewModel: Model
    
    var body: some View {
        NavigationStack {
            GeometryReader { reader in
                ScrollView {
                    if viewModel.isLoading {
                        createLoadingView(reader: reader)
                    } else {
                        createListView
                    }
                }.navigationTitle(GlobalStrings.home)
            }
        }
    }
}

extension HomeScreen {
    @ViewBuilder
    internal func createLoadingView(reader: GeometryProxy) -> some View {
        VStack(alignment: .center) {
            Spacer()
            ProgressView()
                .scaleEffect(2)
            Spacer()
        }.frame(width: reader.size.width,
                height: reader.size.height)
    }
    
    internal var createListView: some View {
        LazyVGrid(columns: createGrid(), content: {
            ForEach(viewModel.pokemonList, id: \.self) { item in
                Button(action: {
                    viewModel.onTapCard(pokemonSelected: item)
                }, label: {
                    CardComponent(imageUrl: URL(string: item.image),
                                  labelName: item.labelName)
                })
            }
        })
    }
    
    internal func createGrid() -> [GridItem] {
        let columns = [
            GridItem(.flexible()),
            GridItem(.flexible())
        ]
        return columns
    }
}
