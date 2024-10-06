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
            SearchPokemon(pokemonName: $pokemonName)

            PokemonsList(viewModel: viewModel)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
        .task {
            await viewModel.fetchPokemons()
        }
    }
}

struct SearchPokemon:View {
    let pokemonName:Binding<String>
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
            TextField("", text: pokemonName, prompt:
                        Text("What Pokémon are you looking for?").font(.callout).bold().foregroundColor(Color.gray))
        }
        .foregroundColor(.gray)
        .padding(16)
        .background(Color.gray.opacity(0.1))
        .cornerRadius(16)
        .padding(16)
        .autocorrectionDisabled()
        .onSubmit {
            print("Searching for \(pokemonName)...")
        }
    }
}

struct PokemonsList:View {
    @ObservedObject var viewModel: PokemonViewModel
    
    var body: some View {
        List(viewModel.pokemons) { pokemon in
            PokemonItem(pokemon: pokemon)
                .listRowSeparator(.hidden)
        }.listStyle(.plain)
        .scrollIndicators(.hidden)
    }
}

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

struct PokemonItemDetails:View {
    let pokemon: ApiNetwork.Pokemon
    var body: some View {
        HStack {
            PokemonItemLeft(pokemon: pokemon)
            Spacer()
            PokemonItemRight(pokemon: pokemon)
        }
    }
}

struct PokemonItemLeft: View {
    let pokemon: ApiNetwork.Pokemon
    var body: some View {
        VStack() {
            if let id = pokemon.details?.id {
                Text(formatPokemonID(id))
                    .font(.caption)
                    .foregroundColor(Color.pokemonId)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
            } else {
                Text("ID: Unknown")
            }
            Text(pokemon.name.capitalized)
                .font(.title2)
                .foregroundColor(Color.white)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack {
               if let types = pokemon.details?.types {
                   ForEach(types, id: \.self) { type in
                       HStack {
                           switchTypeImage(type: type.type.name)
                               .resizable()
                               .scaledToFit()
                               .frame(width: 15, height: 15)
                           Text(type.type.name.capitalized).foregroundColor(.white)
                       }.padding(2).background(colorForPokemonType(type: type.type.name)).bold().cornerRadius(5)
                   }
               }
            }.frame(maxWidth: .infinity, alignment: .leading)
        }.padding(.leading, 20)
    }
}



struct PokemonItemRight: View {
    let pokemon: ApiNetwork.Pokemon

    var body: some View {
        ZStack {
            Image("Pokeball")
                .resizable()
                .scaledToFit()
                .padding(.leading, 24)
            HStack {
                AsyncImage(url: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/\(pokemon.details?.id ?? 0).png")) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 130, height: 130)
                        .cornerRadius(8)
                        .padding(.trailing, 18)
                        .offset(y: -20)
                        .zIndex(1)
                } placeholder: {
                    ProgressView()
                }
            }
            .padding(.leading, 20)
        }
        }
}

#Preview {
    ContentView()
    //PokemonItem(pokemon: ApiNetwork.Pokemon(name:"Mewtwo", url: ""))
}
