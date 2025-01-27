//
//  ContentView.swift
//  Pokedex
//
//  Created by Tomas on 24/9/24.
//

import SwiftUI

struct ContentView: View {
    @State var pokemonName = ""
    @StateObject private var viewModel = PokemonViewModel()
    
    var body: some View {
        VStack {
            SearchPokemon(
                pokemonName: $pokemonName,
                onSearch: { query in
                    viewModel.filterPokemons(by: query)
                }
            )
            PokemonsList(viewModel: viewModel)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
        .task {
            await viewModel.fetchPokemons()
            viewModel.filterPokemons(by: "")
        }
    }
}

#Preview {
    ContentView()
}
