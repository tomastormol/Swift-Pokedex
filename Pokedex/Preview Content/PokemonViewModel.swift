//
//  PokemonViewModel.swift
//  Pokedex
//
//  Created by Tomas on 24/9/24.
//

import Foundation

@MainActor
class PokemonViewModel: ObservableObject {
    @Published var pokemons: [ApiNetwork.Pokemon] = []

    func fetchPokemons() async {
        do {
            let wrapper = try await ApiNetwork().getPokemons()
            var fetchedPokemons: [ApiNetwork.Pokemon] = []

            for pokemon in wrapper.results {
                if let details = await fetchPokemonDetails(url: pokemon.url) {
                    var detailedPokemon = pokemon
                    detailedPokemon.details = details
                    fetchedPokemons.append(detailedPokemon)
                }
            }

            self.pokemons = fetchedPokemons
            print("Total Pokémon after details fetch: \(self.pokemons.count)")
        } catch {
            print("Error fetching Pokémon: \(error)")
        }
    }

    private func fetchPokemonDetails(url: String) async -> ApiNetwork.PokemonDetails? {
        do {
            let (data, _) = try await URLSession.shared.data(from: URL(string: url)!)
            print("Fetched details for Pokémon from \(url)")
            return try JSONDecoder().decode(ApiNetwork.PokemonDetails.self, from: data)
        } catch {
            print("Error fetching Pokémon details: \(error)")
            return nil
        }
    }
}

