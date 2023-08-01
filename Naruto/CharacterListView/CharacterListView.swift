//
//  CharactersListView.swift
//  Naruto
//
//  Created by Khusain on 31.07.2023.
//

import SwiftUI

struct CharacterListView: View {
    @StateObject private var viewModel = CharacterListViewModel()
    
    @State var isSheed = false
    
    var body: some View {
        NavigationView {
            
            List {
                ForEach(viewModel.rows, id: \.characterName) { characterDetailViewModel in
                    NavigationLink(destination: CharacterDetailsView(viewModel: characterDetailViewModel)) {
                        RowView(viewModel: characterDetailViewModel)
                            .onAppear {
                                viewModel.loadNextPageIfNeeded(currentRow: characterDetailViewModel)
                            }
                    }
                    
                }
            }
            .navigationTitle("Characters")
        }
        .task {
            await viewModel.fetchCharacters(page: 1)
        }
    }
}

struct CharactersListView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterListView()
    }
}

