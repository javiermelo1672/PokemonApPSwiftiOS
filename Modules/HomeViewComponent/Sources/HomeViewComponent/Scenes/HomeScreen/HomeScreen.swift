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
                    .navigationBarTitleDisplayMode(.inline).toolbar(content: {
                    ToolbarItem(placement: .topBarTrailing, content: {
                        Button(action: {
                            viewModel.duoColumn.toggle()
                        }, label: {
                            Image(systemName: viewModel.duoColumn ? "list.bullet" : "square.grid.2x2.fill")
                        })
                    })
                })
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
            LazyVGrid(columns: viewModel.columns, content: {
                let indices = pokemonList.pokemonList.indices
                ForEach(indices, id: \.self) { index in
                    let item = pokemonList.pokemonList[index]
                    let isLastItem = index == pokemonList.pokemonList.indices.last
                    Button(action: {
                        viewModel.onTapCard(pokemonSelected: item)
                    }, label: {
                        CardComponent(imageUrl: URL(string: item.image),
                                      labelName: item.labelName)
                    }).onAppear {
                        guard isLastItem && index >= (viewModel.pagination - 1) else { return }
                        viewModel.getItemsPerPagination()
                    }
                }
            }).padding(.horizontal, 15)
            if viewModel.isLoadingPagination {
                ProgressView().padding(.vertical, 30)
            }
        } else {
            skeletonView(view: createEmptyView(), reader: reader)
        }
    }
}
