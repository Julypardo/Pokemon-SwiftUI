//
//  SelectionPokemonViewModel.swift
//  Pokemon-SwiftUI
//
//  Created by July on 4/08/21.
//

import CoreData
import Foundation
import SwiftUI

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
        PokemonAPI.shared.pokemonListRequest(limit: limit, offset: offset) { result, error in
            self.successRequest = error

            if self.successRequest ?? false {
                for item in result! {
                    self.getPokemonInfo(url: item.url ?? "")
                }
            }
        }

        offset = offset + limit
        UserDefaults.standard.set(offset, forKey: "offset")
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
        if position >= 0 {
            x[position] = -500
            degree[position] = -15

            position = position - 1
        }
    }

    func catchPokemon() {
        if position >= 0 {
            x[position] = 500
            degree[position] = 15

            savePokemon()

            position = position - 1
        }
    }

    func discardGesture(value: DragGesture.Value, index: Int) {
        if value.translation.width > 0 {
            x[index] = value.translation.width
            degree[index] = 8
        } else {
            x[index] = value.translation.width
            degree[index] = -8
        }
    }

    func dragEnded(value: DragGesture.Value, index: Int) {
        if value.translation.width > 0 {
            if value.translation.width > 100 {
                catchPokemon()
            } else {
                revertPosition(index: index)
            }
        } else {
            if value.translation.width < -100 {
                rejectPokemon()
            } else {
                revertPosition(index: index)
            }
        }
    }

    func revertPosition(index: Int) {
        x[index] = 0
        degree[index] = 0
    }

    func savePokemon() {
        let pokemon = PokemonDAO(context: CoreDataManager.shared.persistenceContainer.viewContext)
        pokemon.id = Int16(pokemonInfo[position]?.id ?? 0)
        pokemon.name = pokemonInfo[position]?.name ?? ""

        var typesConcat: String = ""
        if pokemonInfo[position]?.types != nil {
            for item in pokemonInfo[position]!.types! {
                typesConcat = typesConcat + (item.type?.name ?? "") + " "
            }
        }
        pokemon.types = typesConcat

        pokemon.image = pokemonInfo[position]?.sprites?.other?.officialArtwork?.frontDefault ?? ""
        pokemon.species = pokemonInfo[position]?.species?.name ?? ""
        pokemon.height = Int16(pokemonInfo[position]?.height ?? 0)
        pokemon.weight = Int16(pokemonInfo[position]?.weight ?? 0)

        var abilitiesConcat: String = ""
        if pokemonInfo[position]?.abilities != nil {
            for item in pokemonInfo[position]!.abilities! {
                abilitiesConcat = abilitiesConcat + (item.ability?.name ?? "") + " "
            }
        }
        pokemon.abilities = abilitiesConcat

        var movesConcat: String = ""
        if pokemonInfo[position]?.moves != nil {
            for item in pokemonInfo[position]!.moves! {
                movesConcat = movesConcat + (item.move?.name ?? "") + " "
            }
        }
        pokemon.moves = movesConcat

        CoreDataManager.shared.save()
    }
}
