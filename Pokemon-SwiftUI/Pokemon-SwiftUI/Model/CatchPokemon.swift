//
//  CatchPokemon.swift
//  Pokemon-SwiftUI
//
//  Created by July on 5/08/21.
//

import Foundation

struct CatchPokemon: Hashable {
    let pokemon: PokemonDAO

    var id: Int {
        return Int(pokemon.id)
    }

    var name: String {
        return pokemon.name ?? ""
    }

    var image: String {
        return pokemon.image ?? ""
    }

    var types: String {
        return pokemon.types ?? ""
    }

    var species: String {
        return pokemon.species ?? ""
    }

    var height: Int {
        return Int(pokemon.height)
    }

    var weight: Int {
        return Int(pokemon.weight)
    }

    var abilities: String {
        return pokemon.abilities ?? ""
    }

    var moves: String {
        return pokemon.moves ?? ""
    }
}
