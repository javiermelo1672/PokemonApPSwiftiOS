//
//  SwiftUIView.swift
//  
//
//  Created by Javier Duvan Hospital Melo on 10/08/24.
//

import SwiftUI

struct CardComponent: View {
    let imageUrl: URL?
    let labelName: String
    var cornerRadious: Double = 15
    
    var body: some View {
        VStack(alignment: .center, spacing: 5, content: {
            AsyncImage(url: imageUrl, content: { image in
                imageGen(image: image)
            }, placeholder: {
                imageGen(image: PokemonAssets.pokeball.swiftUIImage)
            })
            generateLabel(text: labelName)
                .padding(.horizontal, 10)
                .padding(.top, 10)
            Spacer(minLength: 10)
        }).frame(height: 280).background(.ultraThickMaterial, in: RoundedRectangle(cornerRadius: 15))
    }
}

// MARK:- UI Builders
extension CardComponent {
    @ViewBuilder
    internal func generateLabel(text: String) -> some View {
        Text(text.capitalized)
            .foregroundColor(PokemonColor.Colors.pokeBlue.swiftUIColor)
            .lineLimit(2)
            .font(.title3)
            .bold()
    }
    
    @ViewBuilder
    internal func imageGen(image: Image) -> some View {
        image.resizable()
            .aspectRatio(contentMode: .fill)
            .frame(maxHeight: 200)
            .frame(minHeight: 200)
            .clipped()
            .clipShape(RoundedCornersShape(corners: [.topLeft, .topRight], radius: 15))
    }
}

#Preview {
    CardComponent(imageUrl: URL(string: "https://img-cdn.pixlr.com/image-generator/history/65bb506dcb310754719cf81f/ede935de-1138-4f66-8ed7-44bd16efc709/medium.webp")!, labelName: "Gato con Comida").frame(maxWidth: 100)
}
