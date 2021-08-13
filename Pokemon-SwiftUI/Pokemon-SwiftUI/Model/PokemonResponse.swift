//
//  PokemonResponse.swift
//  Pokemon-SwiftUI
//
//  Created by July on 4/08/21.
//

import Foundation

// MARK: - PokemonResponse

struct PokemonResponse: Decodable {
    let count: Int?
    let next: String?
    let results: [Result]?
}

// MARK: - Result

struct Result: Identifiable, Decodable, Encodable, Hashable, Equatable {
    private(set) var id = UUID()
    let name: String?
    let url: String?

    enum CodingKeys: String, CodingKey {
        case name
        case url
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(url)
    }

    static func == (lhs: Result, rhs: Result) -> Bool {
        return lhs.url == rhs.url
    }
}
