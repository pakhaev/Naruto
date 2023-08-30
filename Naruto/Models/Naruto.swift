//
//  Naruto.swift
//  Naruto
//
//  Created by Khusain on 31.07.2023.
//

import Foundation

struct CharacterDebut: Decodable {
    let anime: String?
    let novel: String?
    let movie: String?
    let appearsIn: String?
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

protocol DataResponseProtocol: Decodable {
    associatedtype DataType: Decodable
    
    var data: [DataType] { get }
    var currentPage: Int { get }
    var pageSize: Int { get }
    var totalData: Int { get }
    var defaultImage: String { get }
}

struct CharactersData: DataResponseProtocol {
    let data: [Character]
    let currentPage: Int
    let pageSize: Int
    let totalData: Int
    let defaultImage = "characters"

    enum CodingKeys: String, CodingKey {
        case data = "characters"
        case currentPage
        case pageSize
        case totalData = "totalCharacters"
    }
}

struct TailedBeastsData: DataResponseProtocol {
    let data: [Character]
    let currentPage: Int
    let pageSize: Int
    let totalData: Int
    let defaultImage = "tailed"
    
    enum CodingKeys: String, CodingKey {
        case data = "tailedBeasts"
        case currentPage
        case pageSize
        case totalData = "totalTailedBeasts"
    }
}

struct AkatsukiData: DataResponseProtocol {
    let data: [Character]
    let currentPage: Int
    let pageSize: Int
    let totalData: Int
    let defaultImage = "akatsuki"
    
    enum CodingKeys: String, CodingKey {
        case data = "akatsuki"
        case currentPage
        case pageSize
        case totalData = "totalMembers"
    }
}

struct KaraData: DataResponseProtocol {
    let data: [Character]
    let currentPage: Int
    let pageSize: Int
    let totalData: Int
    let defaultImage = "kara"
    
    enum CodingKeys: String, CodingKey {
        case data = "kara"
        case currentPage
        case pageSize
        case totalData = "totalKara"
    }
}

struct TeamsData: DataResponseProtocol {
    var data: [InfoData]
    var currentPage: Int
    var pageSize: Int
    var totalData: Int
    var defaultImage = "teams"
    
    enum CodingKeys: String, CodingKey {
        case data = "defaultTeams"
        case currentPage
        case pageSize
        case totalData = "totalTeams"
    }
}

struct VillagesData: DataResponseProtocol {
    var data: [InfoData]
    var currentPage: Int
    var pageSize: Int
    var totalData: Int
    var defaultImage = "defaultVillages"
    
    enum CodingKeys: String, CodingKey {
        case data = "villages"
        case currentPage
        case pageSize
        case totalData = "totalVillages"
    }
}

struct KekkeiGenkaiData: DataResponseProtocol {
    var data: [InfoData]
    var currentPage: Int
    var pageSize: Int
    var totalData: Int
    var defaultImage = "defaultGenkai"
    
    enum CodingKeys: String, CodingKey {
        case data = "kekkeigenkai"
        case currentPage
        case pageSize
        case totalData = "totalKekkeiGenkai"
    }
}

struct ClansData: DataResponseProtocol {
    var data: [InfoData]
    var currentPage: Int
    var pageSize: Int
    var totalData: Int
    var defaultImage = "defaultClans"
    
    enum CodingKeys: String, CodingKey {
        case data = "clans"
        case currentPage
        case pageSize
        case totalData = "totalClans"
    }
}

struct InfoData: Decodable, Identifiable {
    let id = UUID()
    let name: String
    let characters: [Character]
}


extension Character {
    static func getCharacter() -> Character {
        Character(
            id: 0,
            name: "Zero-Tails",
            images: [
                "https://static.wikia.nocookie.net/naruto/images/e/e6/Ten-Tails_emerges.png"
                ],
            debut: CharacterDebut(
                anime: "Naruto Shippūden Episode #205",
                novel: "Naruto Shippūden the Movie: Bonds",
                movie: "Naruto Shippūden the Movie: Bonds",
                appearsIn: "Anime, Novel, Movie"
            ),
            jutsu: ["Shadow Arms"],
            personal: nil,
            uniqueTraits: [
                "Detects negative emotions",
                "Feeds on darkness in a beings heart to create dark chakra"
                ]
        )
    }
}
