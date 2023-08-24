//
//  CharactersDetailsViewModel.swift
//  Naruto
//
//  Created by Khusain on 31.07.2023.
//

import Foundation

final class CharacterDetailsViewModel: ObservableObject {
    let id: Int
    let defaultImage: String
    
    var characterName: String {
        character.name
    }
    
    var imageData: URL? {
        guard let firstURL = character.images.last,
              let url = URL(string: firstURL) else {
            return nil
        }
        return url
    }
    
    var debut: String {
        guard let debut = character.debut else {
            return ""
        }
        
        let anime = debut.anime ?? ""
        let novel = debut.novel ?? ""
        let movie = debut.movie ?? ""
        
        var result = "Debut:\n"
        result += (!anime.isEmpty) ? "Anime: \(anime)\n" : ""
        result += (!novel.isEmpty) ? "Novel: \(novel)\n" : ""
        result += (!movie.isEmpty) ? "Movie: \(movie)\n" : ""
        
        return result
    }
    
    var jutsu: String {
        guard let jutsu = character.jutsu else {
            return ""
        }
        
        return "Jutsu: " + jutsu.joined(separator: "\n")
    }
    
    var personal: String {
//        guard let personal = character.personal else { return "" }
//
//        switch personal {
//        case .array(let array):
//            print(array.joined(separator: " "))
//        case .dictionary(let dictionary):
//            print(dictionary.status ?? "status is empty")
//            print(dictionary.titles ?? "status is empty")
//        case .stringValue(_):
//            print("")
//        }
        return ""
    }
    
    private let character: Character
    
    init(character: Character, defaultImage: String) {
        self.character = character
        self.id = character.id
        self.defaultImage = defaultImage
    }
}

extension CharacterDetailsViewModel: Equatable {
    static func == (lhs: CharacterDetailsViewModel, rhs: CharacterDetailsViewModel) -> Bool {
//        print("lhs \(lhs.id) rhs \(rhs.id)")
        return lhs.id == rhs.id
    }
}
