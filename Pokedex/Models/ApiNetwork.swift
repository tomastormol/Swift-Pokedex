//
//  ApiNetwork.swift
//  Pokedex
//
//  Created by Tomas on 24/9/24.
//

import Foundation

class ApiNetwork{
    
    struct Wrapper:Codable{
        let results: [Pokemon]
    }
    
    struct Pokemon:Codable, Identifiable{
        let id = UUID()
        let name: String
        let url: String
        var details: PokemonDetails?
    }
    
    struct PokemonDetails: Codable{
        let id: Int
        let name: String
        let types: [PokemonType]
    }
    
    struct PokemonType: Codable, Hashable{
        let type: PokemonTypeName
    }
    
    struct PokemonTypeName: Codable, Hashable{
        let name: String
    }
    
    func getPokemons() async throws -> Wrapper{
        let PokemonURL = "https://pokeapi.co/api/v2/pokemon?limit=40&offset=0"
        let url = URL(string: PokemonURL)!
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(Wrapper.self, from: data)
    }
    
}
