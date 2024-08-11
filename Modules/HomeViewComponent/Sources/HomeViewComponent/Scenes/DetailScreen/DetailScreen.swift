//
//  SwiftUIView.swift
//  
//
//  Created by Javier Duvan Hospital Melo on 11/08/24.
//

import SwiftUI

public struct DetailScreen<Model>: View where Model: DetailScreenProtocol {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var viewModel: Model
    
    public init() { }
    
    public var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading) {
                    AsyncImage(url: URL(string: viewModel.pokemonSelected.image), content: { image in
                        imageGen(image: image)
                    }, placeholder: {
                        imageGen(image: PokemonAssets.pokeball.swiftUIImage)
                    }).cornerRadius(15)
                    generateLabel(text: viewModel.pokemonSelected.labelName)
                        .padding(.vertical, 15)
                    Text("\(GlobalStrings.weight): \(viewModel.pokemonSelected.pokemonInfo?.weight ?? 0) kg")
                    Text("\(GlobalStrings.height): \(viewModel.pokemonSelected.pokemonInfo?.height ?? 0) cm")
                    generateHabilities()
                        .padding(.vertical, 15)
                    generateStats()
                        .padding(.vertical, 15)
                }.padding(.horizontal, 15)
            }.navigationTitle(GlobalStrings.detail)
                .navigationBarTitleDisplayMode(.inline).toolbar(content: {
                ToolbarItem(placement: .topBarTrailing, content: {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Image(systemName: "x.circle.fill")
                    }).foregroundColor(.gray)
                })
            })
        }
    }
}

extension DetailScreen {
    
    @ViewBuilder
    internal func generateHabilities() -> some View {
        generateLabel(text: GlobalStrings.abilities, font: .body)
        ScrollView(.horizontal,showsIndicators: false, content: {
            HStack {
                ForEach(viewModel.pokemonSelected.pokemonInfo?.abilities ?? [], id: \.self) { item in
                    Image(systemName: "star.circle")
                    Text(item.ability?.name ?? "")
                }
            }
        })
    }
    
    @ViewBuilder
    internal func generateStats() -> some View {
        generateLabel(text: GlobalStrings.statics, font: .body)
        ScrollView(.horizontal,showsIndicators: false, content: {
            HStack {
                ForEach(viewModel.pokemonSelected.pokemonInfo?.stats ?? [], id: \.self) { item in
                    HStack {
                        Image(systemName: "chart.xyaxis.line")
                        VStack(alignment: .leading) {
                            Text(item.stat?.name ?? "")
                            Text("\(GlobalStrings.base): \(item.baseStat ?? 0)")
                            Text("\(GlobalStrings.effort): \(item.effort ?? 0)")
                        }
                    }
                }
            }
        })
    }
}

extension DetailScreen {
    @ViewBuilder
    internal func imageGen(image: Image) -> some View {
        image.resizable()
            .aspectRatio(contentMode: .fill)
            .frame(maxHeight: 300)
            .frame(minHeight: 300)
            .clipped()
            
    }
    
    @ViewBuilder
    internal func generateLabel(text: String, font: Font = .title3) -> some View {
        Text(text.capitalized)
            .foregroundColor(PokemonColor.Colors.pokeBlue.swiftUIColor)
            .lineLimit(2)
            .font(font)
            .bold()
    }
}
