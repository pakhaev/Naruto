//
//  ClansListView.swift
//  Naruto
//
//  Created by Khusain on 31.07.2023.
//

import SwiftUI

struct ClansListView: View {
    @StateObject var viewModel = ClansListViewModel(t: Clans.self, url: .clans)
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]) {
                    
                    ForEach(viewModel.search(), id:\.id) { newValue in
                        NavigationLink {
                            GridView<CharactersData>(
                                viewModel: CharacterListViewModel(
                                    characters: newValue.characters,
                                    defaultImage: "defaultClans"
                                ),
                                title: "Characters"
                            )
                            
                        } label: {
                            VStack {
                                Image(viewModel.defaultImage!)
                                    .resizable()
                                    .frame(width: 100, height: 100)
                                Text(newValue.name)
                            }
                            .onAppear {
                                viewModel.loadNextPageIfNeeded(currentRow: newValue.name)
                            }
                        }
                    }
                    
                }
                .task {
                    await viewModel.fetchInfo()
                    await viewModel.fetchClans(page: 1)
                }
            }
        }
        .searchable(text: $viewModel.searchText)
    }
}

struct ClansListView_Previews: PreviewProvider {
    static var previews: some View {
        ClansListView()
    }
}
