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
    let classification: TeamValue?
    let team: TeamValue?
    let partner: TeamValue?
    let titles: [String]?
    
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
    let personal: PersonalValue?
    let uniqueTraits: [String]?
    
    enum PersonalValue: Decodable {
        case array([String])
        case dictionary(CharacterPersonal)
        case stringValue(String)

        init(from decoder: Decoder) throws {
            if let arrayValue = try? decoder.singleValueContainer().decode([String].self) {
                self = .array(arrayValue)
            } else if let stringValue = try? decoder.singleValueContainer().decode(String.self) {
                self = .stringValue(stringValue)
            } else if let dictionaryValue = try? decoder.singleValueContainer().decode(CharacterPersonal.self) {
                self = .dictionary(dictionaryValue)
            } else {
                throw NetworkError.decodingError
            }
        }
    }
}

struct CharactersData: Decodable {
    let characters: [Character]
    let currentPage: String
    let pageSize: Int
    let totalCharacters: Int
}

struct TailedBeastsData: Decodable {
    let tailedBeasts: [Character]
    let currentPage: String
    let pageSize: Int
    let totalTailedBeasts: Int
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
            personal: nil,
            uniqueTraits: [
                "Detects negative emotions",
                "Feeds on darkness in a beings heart to create dark chakra"
                ]
        )
    }
}
