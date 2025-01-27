//
//  SearchPokemon.swift
//  Pokedex
//
//  Created by Tomas Tortosa Molto on 27/1/25.
//

import SwiftUI

struct SearchPokemon: View {
    @Binding var pokemonName: String
    var onSearch: (String) -> Void
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
            TextField(
                "What Pokémon are you looking for?",
                text: $pokemonName
            )
            .font(.callout)
            .bold()
            .foregroundColor(Color.gray)
            .onChange(of: pokemonName) { newValue in
                onSearch(newValue) // Llamar a la función de búsqueda
            }
        }
        .foregroundColor(.gray)
        .padding(16)
        .background(Color.gray.opacity(0.1))
        .cornerRadius(16)
        .padding(16)
        .autocorrectionDisabled()
    }
}

struct SearchPokemon_Previews: PreviewProvider {
    @State static var pokemonName = ""
    
    static var previews: some View {
        SearchPokemon(pokemonName: $pokemonName, onSearch: { query in
            print("Searching for \(query)...")
        })
    }
}
