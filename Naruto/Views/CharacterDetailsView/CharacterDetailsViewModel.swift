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
    
    @Published var data: [String: [String]] = [:]
    
    private let character: Character
    
    private func getDebut() {
        guard let debut = character.debut else {
            return
        }
        
        var tempArray: [String] = []
        
        if let debut = debut.anime {
            tempArray.append(debut)
        }
        
        if let novel = debut.novel {
            tempArray.append(novel)
        }
        
        if let movie = debut.movie {
            tempArray.append(movie)
        }
        
        if let appearsIn = debut.appearsIn {
            tempArray.append(appearsIn)
        }
        
        data.updateValue(tempArray, forKey: "Debut")
    }
    
    private func getJutsu() {
        guard let jutsu = character.jutsu else {
            return
        }
        
        data.updateValue(jutsu, forKey: "Jutsu")
    }
    
    private func getUniqueTraits() {
        guard let uniqueTraits = character.uniqueTraits else {
            return
        }
        
        data.updateValue(uniqueTraits, forKey: "uniqueTraits")
    }
    
    private func getPersonal() {
        guard let personal = character.personal else {
            print("Return there")
            return
        }
        
        
        switch personal {
        case .array(let array):
            data.updateValue(array, forKey: "Personal")
        case .dictionary(let dict):
            if let species = dict.species {
                data.updateValue([species], forKey: "Species")
            }
            
            if let status = dict.status {
                print("status \(status)")
                data.updateValue([status], forKey: "Status")
            }
            
            if let titles = dict.titles {
                data.updateValue(titles, forKey: "Titles")
            }
            
            getTeamValue(dict.team, key: "Team")
            getTeamValue(dict.classification, key: "Classification")
            getTeamValue(dict.partner, key: "Partner")
            getTeamValue(dict.clan, key: "Clan")
            
        case .stringValue(let str):
            data.updateValue([str], forKey: "Personal")
        }
        
    }
    
    private func getTeamValue(_ value: CharacterPersonal.TeamValue?, key: String) {
        if let value {
            switch value {
            case .string(let str):
                data.updateValue([str], forKey: key)
            case .array(let array):
                data.updateValue(array, forKey: key)
            }
        }
    }
    
    func getInfo() {
        getJutsu()
        getPersonal()
        getDebut()
        
        if data.isEmpty {
            data.updateValue(["There is no information about this character"], forKey: "Ooops...")
        }
        
    }

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
    
    init(character: Character, defaultImage: String) {
        self.character = character
        self.id = character.id
        self.defaultImage = defaultImage
    }
}

extension CharacterDetailsViewModel: Equatable {
    static func == (lhs: CharacterDetailsViewModel, rhs: CharacterDetailsViewModel) -> Bool {
        return lhs.id == rhs.id
    }
}
