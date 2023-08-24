//
//  CharactersClansView.swift
//  Naruto
//
//  Created by Khusain on 11.08.2023.
//

import SwiftUI

struct CharactersClansView: View {
    let characters: [Character]
    
    var body: some View {
        ForEach(characters, id: \.id) { character in
            Text(character.name)
        }
    }
}

struct CharactersClansView_Previews: PreviewProvider {
    static var previews: some View {
        CharactersClansView(characters: [Character.getCharacter()])
    }
}
