//
//  PokemonApiApp.swift
//  PokemonApi
//
//  Created by Javier Duvan Hospital Melo on 10/08/24.
//

import SwiftUI
import HomeViewComponent

@main
struct PokemonApiApp: App {
    @State var showSplashScreen: Bool = true
    var body: some Scene {
        WindowGroup {
            if showSplashScreen {
                SplashScreen().onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                        self.showSplashScreen = false
                    })
                }
            } else {
                HomeView()
            }
        }
    }
}
