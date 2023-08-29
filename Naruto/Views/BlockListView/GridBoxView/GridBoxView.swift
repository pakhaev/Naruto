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
                    
                    ForEach(viewModel.search(), id:\.id) { newValue in
                        NavigationLink {
                            GridView<CharactersData>(
                                viewModel: CharacterListViewModel(
                                    characters: newValue.characters,
                                    defaultImage: viewModel.defaultImage ?? "defaultImage"
                                ),
                                title: "Characters",
                                showButton: false,
                                showMenu: Binding.constant(false)
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
                .navigationTitle(title)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        MenuButtons(showMenu: $showMenu)
                    }
                }
            }
        }
        .task {
            await viewModel.fetchInfo()
            await viewModel.fetchClans(page: 1)
        }
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
