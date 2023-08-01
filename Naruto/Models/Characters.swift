//
//  Characters.swift
//  Naruto
//
//  Created by Khusain on 31.07.2023.
//

import Foundation

struct CharacterDebut: Decodable {
    let anime: String?
    let novel: String?
    let movie: String?
}

struct CharacterPersonal: Decodable {
    let species: String?
    let status: String?
    let classification: String?
    let titles: [String]?
    let team: TeamValue?
    let partner: String?
    
    enum TeamValue: Decodable {
        case string(String)
        case array([String])
        
        init(from decoder: Decoder) throws {
            if let stringValue = try? decoder.singleValueContainer().decode(String.self) {
                self = .string(stringValue)
            } else if let arrayValue = try? decoder.singleValueContainer().decode([String].self) {
                self = .array(arrayValue)
            } else {
                throw NetworkError.decodingError
            }
        }
    }

}

struct Character: Decodable {
    let id: Int
    let name: String
    let images: [String]
    let debut: CharacterDebut?
    let jutsu: [String]?
//    let personal: CharacterPersonal?
    let uniqueTraits: [String]?
}

struct CharactersData: Decodable {
    let characters: [Character]
    let currentPage: String
    let pageSize: Int
    let totalCharacters: Int
}


extension Character {
    static func getCharacter() -> Character {
        Character(
            id: 0,
            name: "Zero-Tails",
            images: [
                "https://static.wikia.nocookie.net/naruto/images/e/e6/Ten-Tails_emerges.png"
                ],
            debut: CharacterDebut(anime: "Naruto Shippūden Episode #205", novel: "Naruto Shippūden the Movie: Bonds", movie: "Naruto Shippūden the Movie: Bonds"),
            jutsu: ["Shadow Arms"],
//            personal: CharacterPersonal(species: "Leech", status: nil, classification: nil, titles: nil, team: nil, partner: nil),
            uniqueTraits: [
                "Detects negative emotions",
                "Feeds on darkness in a beings heart to create dark chakra"
                ]
        )
    }
}
