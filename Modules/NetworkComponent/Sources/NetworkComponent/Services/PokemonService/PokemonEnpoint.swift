//
//  PokemonEnpoint.swift
//  
//
//  Created by Javier Duvan Hospital Melo on 10/08/24.
//

import Foundation

public enum PokemonEnpoint {
    case get

    public func url(baseURL: URL) -> URL {
        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        return components?.url ?? baseURL
    }
}
