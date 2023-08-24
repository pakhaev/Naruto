//
//  CharactersListView.swift
//  Naruto
//
//  Created by Khusain on 31.07.2023.
//

import SwiftUI

struct CharacterListView: View {
    var body: some View {
        let charactersDataViewModel = CharacterListViewModel<CharactersData>(t: CharactersData.self, url: API.characters)
        
        NavigationView {
            GridView(viewModel: charactersDataViewModel, title: "Characters")
        }
        
        
    }
}

struct CharactersListView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterListView()
    }
}
