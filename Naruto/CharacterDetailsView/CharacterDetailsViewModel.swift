//
//  CharactersDetailsViewModel.swift
//  Naruto
//
//  Created by Khusain on 31.07.2023.
//

import Foundation

final class CharacterDetailsViewModel: ObservableObject {
    var characterName: String {
        character.name
    }
    
    var imageData: URL? {
//        if character.images.isEmpty {
//            return nil
//        }
        guard let firstURL = character.images.last,
              let url = URL(string: firstURL) else {
            return nil
        }
//        let url = URL(string: character.images.last!)
        return url
    }
    
    var debut: String {
        guard let debut = character.debut else {
            return ""
        }
        
        let anime = debut.anime ?? ""
        let novel = debut.novel ?? ""
        let movie = debut.movie ?? ""
        
        var result = ""
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
    
    private let character: Character
    
    init(character: Character) {
        self.character = character
    }
}

extension CharacterDetailsViewModel: Equatable {
    static func == (lhs: CharacterDetailsViewModel, rhs: CharacterDetailsViewModel) -> Bool {
        // Верните true, если ваши объекты должны считаться эквивалентными
        // Например, если у вас есть уникальный идентификатор персонажа, вы можете сравнивать их по этому идентификатору.
        return lhs.characterName == rhs.characterName // Здесь characterName - это ваш уникальный идентификатор
    }
}
