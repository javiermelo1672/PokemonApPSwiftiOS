//
//  PokemonInfoUseCase.swift
//  PokemonApi
//
//  Created by Javier Duvan Hospital Melo on 10/08/24.
//

import Foundation
import Combine
import HomeViewComponent

protocol PokemonInfoUseCase {
    func invoke(_ nextUrl: String, cancellables: inout Set<AnyCancellable>, response: @escaping (PokemonModelList?) -> Void)
    func invoke(_ baseurl: String, cancellables: inout Set<AnyCancellable>, completion: @escaping (PokemonInfoModel?) -> Void)
}
