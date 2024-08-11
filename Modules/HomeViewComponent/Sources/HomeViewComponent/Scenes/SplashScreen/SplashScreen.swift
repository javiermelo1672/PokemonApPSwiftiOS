//
//  SwiftUIView.swift
//  
//
//  Created by Javier Duvan Hospital Melo on 10/08/24.
//

import SwiftUI

public struct SplashScreen: View {
    public init() {
    }
    public var body: some View {
        VStack(alignment: .center) {
            Spacer()
            PokemonAssets.pokemonSplash.swiftUIImage
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 150)
            ProgressView()
                .tint(.white)
            Spacer()
        }.frame(maxWidth: .infinity).background(.black)
    }
}

#Preview {
    SplashScreen()
}
