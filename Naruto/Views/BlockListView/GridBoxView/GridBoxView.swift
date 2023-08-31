//
//  GridBoxView.swift
//  Naruto
//
//  Created by Khusain on 29.08.2023.
//

import SwiftUI

struct GridBoxView<T: DataResponseProtocol>: View {
    
    @StateObject var viewModel: BlockListViewModel<T>
    
    let title: String
    let defaultImage: String
    
    @Binding var showMenu: Bool
    
    var body: some View {
        ScrollView {
            if viewModel.loadedData {
                HStack {
                    Spacer()
                    
                    ProgressView("Loading...")
                        .progressViewStyle(CircularProgressViewStyle())
                        .padding()
                    
                    Spacer()
                }
            } else {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]) {
                    
                    if let tempBoxing = viewModel.tempInfo {
                        NavigationLink {
                            GridView<CharactersData>(
                                viewModel: CharacterListViewModel(
                                    characters: tempBoxing.characters,
                                    defaultImage: "defaultImage"
                                ),
                                title: "Characters",
                                showButton: false,
                                showMenu: $showMenu
                            )
                        } label: {
                            VStack {
                                Image(viewModel.defaultImage!)
                                    .resizable()
                                    .frame(width: 150, height: 150)
                                    .cornerRadius(20)
                                Text(tempBoxing.name)
                            }
                        }

                    }
                    
                    ForEach(viewModel.search(), id:\.id) { newValue in
                        NavigationLink {
                            GridView<CharactersData>(
                                viewModel: CharacterListViewModel(
                                    characters: newValue.characters,
                                    defaultImage: "characters"
                                ),
                                title: "Characters",
                                showButton: false,
                                showMenu: Binding.constant(false)
                            )
                            
                        } label: {
                            VStack {
                                Image(viewModel.defaultImage!)
                                    .resizable()
                                    .frame(width: 150, height: 150)
                                    .cornerRadius(20)
                                Text(newValue.name)
                            }
                            .onAppear {
                                viewModel.loadNextPageIfNeeded(currentRow: newValue.name)
                            }
                        }
                    }
                }
                .navigationTitle(title)
                .toolbarColorScheme(.light, for: .navigationBar)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        MenuButtons(showMenu: $showMenu)
                    }
                }
                .toolbarBackground(
                    Color.yellow,
                    for: .navigationBar
                )
            }
        }
        .task {
            await viewModel.fetchInfo()
            await viewModel.fetchClans(page: 1)
        }
        .animation(.default, value: viewModel.searchText)
        .searchable(text: $viewModel.searchText)
        .onChange(of: viewModel.searchText) { _ in
            viewModel.sleepFetchSearch()
        }
        .background(
            LinearGradient(
            gradient: Gradient(colors: [Color("Yellow"), Color("Orange")]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
            )
        )
    }
}

struct GridBoxView_Previews: PreviewProvider {
    static var previews: some View {
        NarutoView()
    }
}
