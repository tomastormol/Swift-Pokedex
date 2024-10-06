//
//  Utilities.swift
//  Pokedex
//
//  Created by Tomas on 25/9/24.
//

import Foundation
import SwiftUI

func formatPokemonID(_ id: Int) -> String {
    if id < 10 {
        return "#00\(id)"
    } else if id < 100 {
        return "#0\(id)"
    } else {
        return "#\(id)"
    }
}

func colorForPokemonBackground(type: String) -> Color {
    let cardColors: [String: Color] = [
        "grass": Color(red: 139/255, green: 190/255, blue: 138/255),
        "fire": Color(red: 255/255, green: 167/255, blue: 86/255),
        "water": Color(red: 88/255, green: 171/255, blue: 246/255),
        "poison": Color(red: 159/255, green: 110/255, blue: 151/255),
        "normal": Color(red: 181/255, green: 185/255, blue: 196/255),
        "bug": Color(red: 139/255, green: 214/255, blue: 116/255),
        "flying": Color(red: 116/255, green: 143/255, blue: 201/255),
        "electric": Color(red: 242/255, green: 203/255, blue: 85/255),
        "ground": Color(red: 247/255, green: 133/255, blue: 81/255),
        "fairy": Color(red: 237/255, green: 110/255, blue: 199/255),
        "fighting": Color(red: 208/255, green: 65/255, blue: 100/255),
        "psychic": Color(red: 234/255, green: 93/255, blue: 96/255),
        "rock": Color(red: 186/255, green: 171/255, blue: 130/255),
        "ghost": Color(red: 85/255, green: 106/255, blue: 174/255),
        "ice": Color(red: 97/255, green: 206/255, blue: 192/255),
        "dragon": Color(red: 15/255, green: 106/255, blue: 192/255)
    ]
    
    return cardColors[type] ?? Color.gray // Devuelve gris si el tipo no está encontrado
}

func colorForPokemonType(type: String) -> Color {
    let typeColors: [String: Color] = [
        "grass": Color(red: 98/255, green: 185/255, blue: 87/255),
        "fire": Color(red: 253/255, green: 125/255, blue: 36/255),
        "water": Color(red: 74/255, green: 144/255, blue: 218/255),
        "poison": Color(red: 165/255, green: 82/255, blue: 204/255),
        "normal": Color(red: 157/255, green: 160/255, blue: 170/255),
        "bug": Color(red: 140/255, green: 179/255, blue: 48/255),
        "flying": Color(red: 116/255, green: 143/255, blue: 201/255),
        "electric": Color(red: 238/255, green: 213/255, blue: 53/255),
        "ground": Color(red: 221/255, green: 119/255, blue: 72/255),
        "fairy": Color(red: 235/255, green: 168/255, blue: 195/255),
        "fighting": Color(red: 235/255, green: 169/255, blue: 113/255),
        "psychic": Color(red: 255/255, green: 101/255, blue: 104/255),
        "rock": Color(red: 212/255, green: 194/255, blue: 148/255),
        "ghost": Color(red: 133/255, green: 113/255, blue: 190/255),
        "ice": Color(red: 145/255, green: 216/255, blue: 223/255),
        "dragon": Color(red: 115/255, green: 131/255, blue: 185/255)
    ]
    
    return typeColors[type] ?? Color.gray
}

func switchTypeImage(type: String) -> Image {
    let typeImages: [String: Image] = [
        "grass": Image("grass"),
        "fire": Image("fire"),
        "water": Image("water"),
        "poison": Image("poison"),
        "normal": Image("normal"),
        "bug": Image("bug"),
        "flying": Image("flying"),
        "electric": Image("electric"),
        "ground": Image("ground"),
        "fairy": Image("fairy"),
        "fighting": Image("fighting"),
        "psychic": Image("psychic"),
        "rock": Image("rock"),
        "ghost": Image("ghost"),
        "ice": Image("ice"),
        "dragon": Image("dragon"),
        ]
        
        return typeImages[type] ?? Image(systemName: "square")
}
