//
//  CharactersListView.swift
//  Naruto
//
//  Created by Khusain on 31.07.2023.
//

import SwiftUI
import Kingfisher


struct CharacterListView: View {
    @StateObject private var viewModel = CharacterListViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]) {
                    
                    if let tempCharacter = viewModel.tempCharacter {
                        NavigationLink(destination: CharacterDetailsView(viewModel: tempCharacter)) {
                            GridElementView(viewModel: tempCharacter)
                        }
                    }
                    
                    ForEach(viewModel.searchResults(), id: \.characterName) { characterDetailViewModel in
                        NavigationLink(destination: CharacterDetailsView(viewModel: characterDetailViewModel)) {
                            GridElementView(viewModel: characterDetailViewModel)
                            .onAppear {
                                viewModel.loadNextPageIfNeeded(currentRow: characterDetailViewModel)
                            }
                        } //:NAVIGATIONLINK
                    }
                }
                .animation(.default, value: viewModel.searchText)
                .navigationTitle("Characters")
            }
        }
        .task {
            await viewModel.fetchCharacters(page: 1)
        }
        .searchable(text: $viewModel.searchText)
        .onChange(of: viewModel.searchText) { _ in
            viewModel.sleepFetchSearch()
        }
    }
}

struct CharactersListView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterListView()
    }
}

