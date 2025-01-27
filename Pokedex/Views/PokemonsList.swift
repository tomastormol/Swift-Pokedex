//
//  PokemonList.swift
//  Pokedex
//
//  Created by Tomas Tortosa Molto on 27/1/25.
//

import SwiftUI

struct PokemonsList: View {
    @ObservedObject var viewModel: PokemonViewModel
    
    var body: some View {
        List(viewModel.filteredPokemons) { pokemon in
            PokemonItem(pokemon: pokemon)
                .listRowSeparator(.hidden)
        }.listStyle(.plain)
        .scrollIndicators(.hidden)
    }
}
