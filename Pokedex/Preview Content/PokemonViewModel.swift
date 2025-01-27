//
//  PokemonViewModel.swift
//  Pokedex
//
//  Created by Tomas on 24/9/24.
//

import Foundation

@MainActor
class PokemonViewModel: ObservableObject {
    @Published var allPokemons: [ApiNetwork.Pokemon] = []
    @Published var filteredPokemons: [ApiNetwork.Pokemon] = [] // Pokémon filtrados

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

            self.allPokemons = fetchedPokemons
            self.filteredPokemons = fetchedPokemons
            print("Total Pokémon after details fetch: \(self.allPokemons.count)")
        } catch {
            print("Error fetching Pokémon: \(error)")
        }
    }

    func filterPokemons(by query: String) {
        print("Hola filterPokemons")
        print(query)
            if query.isEmpty {
                filteredPokemons = allPokemons // Si no hay búsqueda, mostramos todos
            } else {
                print("estoy")
                filteredPokemons = allPokemons.filter { $0.name.lowercased().contains(query.lowercased()) }
            }
        }
    
    private func fetchPokemonDetails(url: String) async -> ApiNetwork.PokemonDetails? {
        do {
            let (data, _) = try await URLSession.shared.data(from: URL(string: url)!)
            //print("Fetched details for Pokémon from \(url)")
            return try JSONDecoder().decode(ApiNetwork.PokemonDetails.self, from: data)
        } catch {
            print("Error fetching Pokémon details: \(error)")
            return nil
        }
    }
}

