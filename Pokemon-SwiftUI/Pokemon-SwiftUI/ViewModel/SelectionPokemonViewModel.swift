//
//  SelectionPokemonViewModel.swift
//  Pokemon-SwiftUI
//
//  Created by July on 4/08/21.
//

import Foundation
import SwiftUI
import CoreData

class PokemonCardViewModel: ObservableObject {
    
    // MARK: Public values
    @Published var successRequest: Bool?
    @Published var pokemonList: [Result]?
    @Published var pokemonInfo: [Pokemon?] = []
    
    @Published var x: [CGFloat] = []
    @Published var degree: [Double] = []
    @Published var position: Int = -1
    @Published var animateStrokeStart: Bool = false
    @Published var animateStrokeEnd: Bool = true
    @Published var isRotating: Bool = true
    
    // MARK: Private values
    private var limit: Int = 10
    private var offset: Int = UserDefaults.standard.integer(forKey: "offset")
    
    
    func getPokemonList() {
        PokemonAPI.shared.pokemonListRequest(limit: self.limit, offset: self.offset) { result, error  in
            self.successRequest = error
            
            if self.successRequest ?? false {
                for item in result! {
                    self.getPokemonInfo(url: item.url ?? "")
                }
            }
        }
        
        self.offset = self.offset + self.limit
        UserDefaults.standard.set(self.offset, forKey: "offset")
    }
    
    func getPokemonInfo(url: String) {
        if !url.isEmpty {
            PokemonAPI.shared.pokemonInfoRequest(url: url) { result, error in
                self.successRequest = error
                self.pokemonInfo.append(result)
                self.x.append(0)
                self.degree.append(0)
                self.position = self.pokemonInfo.count - 1
            }
        }
    }
    
    
    func rejectPokemon() {
        if self.position >= 0 {
            self.x[self.position] = -500
            self.degree[self.position] = -15
            
            self.position = self.position - 1
        }
    }
    
    func catchPokemon() {
        if self.position >= 0 {
            self.x[self.position] = 500
            self.degree[self.position] = 15
            
            self.savePokemon()
            
            self.position = self.position - 1
        }
    }
    
    func discardGesture(value: DragGesture.Value, index: Int) {
        if value.translation.width > 0 {
            self.x[index] = value.translation.width
            self.degree[index] = 8
        } else {
            self.x[index] = value.translation.width
            self.degree[index] = -8
        }
    }
    
    func dragEnded(value: DragGesture.Value, index: Int) {
        if value.translation.width > 0 {
            if value.translation.width > 100 {
                self.catchPokemon()
            } else {
                self.revertPosition(index: index)
            }
        } else {
            if value.translation.width < -100 {
                self.rejectPokemon()
            } else {
                self.revertPosition(index: index)
            }
        }
    }
    
    func revertPosition(index: Int) {
        self.x[index] = 0
        self.degree[index] = 0
    }
    
    
    func savePokemon() {
        let pokemon = PokemonDAO(context: CoreDataManager.shared.persistenceContainer.viewContext)
        pokemon.id = Int16(self.pokemonInfo[self.position]?.id ?? 0)
        pokemon.name = self.pokemonInfo[self.position]?.name ?? ""
        
        var typesConcat: String = ""
        if self.pokemonInfo[self.position]?.types != nil {
            for item in self.pokemonInfo[self.position]!.types! {
                typesConcat = typesConcat + (item.type?.name ?? "") + " "
            }
        }
        pokemon.types = typesConcat
        
        pokemon.image = self.pokemonInfo[self.position]?.sprites?.other?.officialArtwork?.frontDefault ?? ""
        pokemon.species = self.pokemonInfo[self.position]?.species?.name ?? ""
        pokemon.height = Int16(self.pokemonInfo[self.position]?.height ?? 0)
        pokemon.weight = Int16(self.pokemonInfo[self.position]?.weight ?? 0)
        
        var abilitiesConcat: String = ""
        if self.pokemonInfo[self.position]?.abilities != nil {
            for item in self.pokemonInfo[self.position]!.abilities! {
                abilitiesConcat = abilitiesConcat + (item.ability?.name ?? "") + " "
            }
        }
        pokemon.abilities = abilitiesConcat
        
        var movesConcat: String = ""
        if self.pokemonInfo[self.position]?.moves != nil {
            for item in self.pokemonInfo[self.position]!.moves! {
                movesConcat = movesConcat + (item.move?.name ?? "") + " "
            }
        }
        pokemon.moves = movesConcat
        
        CoreDataManager.shared.save()
    }
}
