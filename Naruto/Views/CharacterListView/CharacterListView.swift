//
//  CharactersListView.swift
//  Naruto
//
//  Created by Khusain on 31.07.2023.
//

import SwiftUI

struct CharacterListView<T: DataResponseProtocol>: View {
    
    let dataType: T.Type
    let url: API
    let title: String
    
    @Binding var showMenu: Bool
    
    var body: some View {
        let viewModel = CharacterListViewModel<T>(type: dataType, url: url)

        NavigationView {
            GridView(viewModel: viewModel, title: title, showButton: true, showMenu: $showMenu)
        }
        .onAppear {
            withAnimation(.spring()) {
                showMenu = false
            }
        }
        
    }
}

struct CharactersListView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterListView<CharactersData>(
            dataType: CharactersData.self,
            url: API.characters,
            title: "Characters",
            showMenu: Binding.constant(false)
        )
    }
}
