//
//  Pokemon.swift
//  Pokemon
//
//  Created by July on 4/08/21.
//

import Foundation

// MARK: - Pokemon

struct Pokemon: Identifiable, Decodable, Encodable, Hashable, Equatable {
    private(set) var uuid = UUID()
    let abilities: [Ability]?
    let baseExperience: Int?
    let forms: [Species]?
    let gameIndices: [GameIndex]?
    let height: Int?
    let id: Int?
    let isDefault: Bool?
    let locationAreaEncounters: String?
    let moves: [Move]?
    let name: String?
    let order: Int?
    let species: Species?
    let sprites: Sprites?
    let stats: [Stat]?
    let types: [TypeElement]?
    let weight: Int?

    enum CodingKeys: String, CodingKey {
        case abilities
        case baseExperience
        case forms
        case gameIndices
        case height
        case id
        case isDefault
        case locationAreaEncounters
        case moves
        case name
        case order
        case species
        case sprites
        case stats
        case types
        case weight
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: Pokemon, rhs: Pokemon) -> Bool {
        return lhs.id == rhs.id
    }
}

// MARK: - Ability

struct Ability: Decodable, Encodable, Hashable, Equatable {
    let ability: Species?
    let isHidden: Bool?
    let slot: Int?

    enum CodingKeys: String, CodingKey {
        case ability
        case isHidden
        case slot
    }

    static func == (lhs: Ability, rhs: Ability) -> Bool {
        return lhs.slot == rhs.slot
    }
}

// MARK: - Species

struct Species: Decodable, Encodable, Hashable, Equatable {
    private(set) var id = UUID()
    let name: String?
    let url: String?

    enum CodingKeys: String, CodingKey {
        case name
        case url
    }

    static func == (lhs: Species, rhs: Species) -> Bool {
        return lhs.url == rhs.url
    }
}

// MARK: - GameIndex

struct GameIndex: Decodable, Encodable {
    let gameIndex: Int?
    let version: Species?

    enum CodingKeys: String, CodingKey {
        case gameIndex
        case version
    }

    static func == (lhs: GameIndex, rhs: GameIndex) -> Bool {
        return lhs.gameIndex == rhs.gameIndex
    }
}

// MARK: - Move

struct Move: Decodable, Encodable, Hashable, Equatable {
    let move: Species?
    let versionGroupDetails: [VersionGroupDetail]?

    enum CodingKeys: String, CodingKey {
        case move
        case versionGroupDetails
    }

    static func == (lhs: Move, rhs: Move) -> Bool {
        return lhs.move == rhs.move
    }
}

// MARK: - VersionGroupDetail

struct VersionGroupDetail: Decodable, Encodable, Hashable, Equatable {
    let levelLearnedAt: Int?
    let moveLearnMethod, versionGroup: Species?

    enum CodingKeys: String, CodingKey {
        case levelLearnedAt
        case moveLearnMethod
        case versionGroup
    }

    static func == (lhs: VersionGroupDetail, rhs: VersionGroupDetail) -> Bool {
        return lhs.levelLearnedAt == rhs.levelLearnedAt
    }
}

// MARK: - GenerationV

struct GenerationV: Decodable, Encodable {
    let blackWhite: Sprites?
}

// MARK: - GenerationIv

struct GenerationIv: Decodable, Encodable {
    let diamondPearl, heartgoldSoulsilver, platinum: Sprites?
}

// MARK: - Versions

struct Versions: Decodable, Encodable {
    let generationI: GenerationI?
    let generationIi: GenerationIi?
    let generationIii: GenerationIii?
    let generationIv: GenerationIv?
    let generationV: GenerationV?
    let generationVi: [String: GenerationVi]?
    let generationVii: GenerationVii?
    let generationViii: GenerationViii?
}

// MARK: - Sprites

class Sprites: Decodable, Encodable {
    let backDefault: String?
    let backFemale: String?
    let backShiny: String?
    let backShinyFemale: String?
    let frontDefault: String?
    let frontFemale: String?
    let frontShiny: String?
    let frontShinyFemale: String?
    let other: Other?
    let versions: Versions?
    let animated: Sprites?

    enum CodingKeys: String, CodingKey {
        case backDefault
        case backFemale
        case backShiny
        case backShinyFemale
        case frontDefault
        case frontFemale
        case frontShiny
        case frontShinyFemale
        case other
        case versions
        case animated
    }
}

// MARK: - GenerationI

struct GenerationI: Decodable, Encodable {
    let redBlue, yellow: RedBlue?
}

// MARK: - RedBlue

struct RedBlue: Decodable, Encodable {
    let backDefault, backGray, frontDefault, frontGray: String?
}

// MARK: - GenerationIi

struct GenerationIi: Decodable, Encodable {
    let crystal, gold, silver: Crystal?
}

// MARK: - Crystal

struct Crystal: Decodable, Encodable {
    let backDefault, backShiny, frontDefault, frontShiny: String?
}

// MARK: - GenerationIii

struct GenerationIii: Decodable, Encodable {
    let emerald: Emerald?
    let fireredLeafgreen, rubySapphire: Crystal?
}

// MARK: - Emerald

struct Emerald: Decodable, Encodable {
    let frontDefault, frontShiny: String?
}

// MARK: - GenerationVi

struct GenerationVi: Decodable, Encodable {
    let frontDefault: String?
    let frontFemale: String?
    let frontShiny: String?
    let frontShinyFemale: String?
}

// MARK: - GenerationVii

struct GenerationVii: Decodable, Encodable {
    let icons: DreamWorld?
    let ultraSunUltraMoon: GenerationVi?
}

// MARK: - DreamWorld

struct DreamWorld: Decodable, Encodable {
    let frontDefault: String?
    let frontFemale: String?
}

// MARK: - GenerationViii

struct GenerationViii: Decodable, Encodable {
    let icons: DreamWorld?
}

// MARK: - Other

struct Other: Decodable, Encodable {
    let dreamWorld: DreamWorld?
    let officialArtwork: OfficialArtwork?

    enum CodingKeys: String, CodingKey {
        case dreamWorld = "dream_world"
        case officialArtwork = "official-artwork"
    }
}

// MARK: - OfficialArtwork

struct OfficialArtwork: Decodable, Encodable {
    let frontDefault: String?

    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}

// MARK: - Stat

struct Stat: Decodable, Encodable {
    let baseStat, effort: Int?
    let stat: Species?
}

// MARK: - TypeElement

struct TypeElement: Decodable, Encodable, Hashable, Equatable {
    private(set) var id = UUID()
    let slot: Int?
    let type: Species?

    enum CodingKeys: String, CodingKey {
        case slot
        case type
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: TypeElement, rhs: TypeElement) -> Bool {
        return lhs.id == rhs.id
    }
}
