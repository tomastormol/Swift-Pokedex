//
//  PokemonItemDetails.swift
//  Pokedex
//
//  Created by Tomas Tortosa Molto on 27/1/25.
//

import SwiftUI

struct PokemonItemDetails:View {
    let pokemon: ApiNetwork.Pokemon
    var body: some View {
        HStack {
            PokemonItemLeft(pokemon: pokemon)
                .frame(width: UIScreen.main.bounds.width * 0.6)
            Spacer()
            PokemonItemRight(pokemon: pokemon)
                .frame(width: UIScreen.main.bounds.width * 0.3)
        }
    }
}

struct PokemonItemLeft: View {
    let pokemon: ApiNetwork.Pokemon
    var body: some View {
        VStack() {
            if let id = pokemon.details?.id {
                Text(formatPokemonID(id))
                    .font(.callout)
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
                       }.padding(6).background(colorForPokemonType(type: type.type.name)).bold().cornerRadius(5)
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
