//
//  SwiftUIView.swift
//  
//
//  Created by Javier Duvan Hospital Melo on 10/08/24.
//

import SwiftUI

public struct HomeScreen<Model>: View where Model: HomeScreenProtocol {
    
    @EnvironmentObject var viewModel: Model
    
    public init() {
    }
    
    public var body: some View {
        NavigationStack {
            GeometryReader { reader in
                ScrollView {
                    if viewModel.isLoading {
                        createLoadingView(reader: reader)
                    } else {
                        createListView(reader: reader)
                    }
                }.navigationTitle(GlobalStrings.home)
            }
        }
    }
}

extension HomeScreen {
    @ViewBuilder
    internal func createLoadingView(reader: GeometryProxy) -> some View {
        skeletonView(view: ProgressView()
            .scaleEffect(2), reader: reader)
    }
    
    @ViewBuilder
    internal func createEmptyView() -> some View {
        Text(GlobalStrings.emptyMessage).font(.body)
    }
    
    @ViewBuilder
    internal func skeletonView(view: any View, reader: GeometryProxy) -> some View {
        VStack(alignment: .center) {
            Spacer()
            AnyView(view)
            Spacer()
        }.frame(width: reader.size.width,
                height: reader.size.height)
    }
    
    
    @ViewBuilder
    internal func createListView(reader: GeometryProxy) -> some View {
        if let pokemonList = viewModel.pokemonList {
            LazyVGrid(columns: createGrid(), content: {
                ForEach(pokemonList.pokemonList, id: \.self) { item in
                    Button(action: {
                        viewModel.onTapCard(pokemonSelected: item)
                    }, label: {
                        CardComponent(imageUrl: URL(string: item.image),
                                      labelName: item.labelName)
                    })
                }
            }).padding(.horizontal, 15)
        } else {
            skeletonView(view: createEmptyView(), reader: reader)
        }
    }
    
    internal func createGrid() -> [GridItem] {
        let columns = [
            GridItem(.flexible()),
            GridItem(.flexible())
        ]
        return columns
    }
}
