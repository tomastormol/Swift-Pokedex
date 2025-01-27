//
//  PokemonItem.swift
//  Pokedex
//
//  Created by Tomas Tortosa Molto on 27/1/25.
//

import SwiftUI

struct PokemonItem: View {
    let pokemon: ApiNetwork.Pokemon
    var body: some View {
        ZStack {
            colorForPokemonBackground(type: pokemon.details?.types.first?.type.name ?? "")
                .cornerRadius(16)
            
            PokemonItemDetails(pokemon: pokemon)
        }
        .frame(height: 115)
        .listRowBackground(Color.clear)
        .padding(.vertical, 8)
    }
}


