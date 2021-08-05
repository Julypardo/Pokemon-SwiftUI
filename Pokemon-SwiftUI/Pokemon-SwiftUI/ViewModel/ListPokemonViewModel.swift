//
//  ListPokemonViewModel.swift
//  Pokemon-SwiftUI
//
//  Created by July on 5/08/21.
//

import Foundation

class ListPokemonViewModel: ObservableObject {
    
    @Published var pokemons: [CatchPokemon] = []
    
    func getCaughtPokemons() {
        self.pokemons = CoreDataManager.shared.getAllPokemons().map(CatchPokemon.init)
    }
}
