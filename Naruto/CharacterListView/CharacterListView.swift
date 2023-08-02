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
    
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]) {
                    ForEach(viewModel.searchResults(), id: \.characterName) { characterDetailViewModel in
                        NavigationLink(destination: CharacterDetailsView(viewModel: characterDetailViewModel)) {
                            GridElementView(viewModel: characterDetailViewModel)
                            .onAppear {
                                viewModel.loadNextPageIfNeeded(currentRow: characterDetailViewModel)
                            }
                        } //:NAVIGATIONLINK
                    }
                }
                .navigationTitle("Characters")
            }
        }
        .task {
            await viewModel.fetchCharacters(page: 1)
        }
        .searchable(text: $viewModel.searchText)
        .onChange(of: viewModel.searchText) { searchText in
            viewModel.searchTask?.cancel()
            
            viewModel.searchTask = Task.detached {
                do {
                    try await Task.sleep(nanoseconds: 1_000_000_000)
                } catch {
                    print(error)
                }
                
                if Task.isCancelled {
                    print("Задача была отменена")
                    return
                }
                await viewModel.fetchSearch()
            }
        }
    }
}

struct CharactersListView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterListView()
    }
}

