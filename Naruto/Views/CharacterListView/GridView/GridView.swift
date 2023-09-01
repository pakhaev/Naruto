//
//  GridView.swift
//  Naruto
//
//  Created by Khusain on 01.08.2023.
//

import SwiftUI

struct GridView<T: DataResponseProtocol>: View {
    @StateObject var viewModel: CharacterListViewModel<T>
    let title: String
    let showButton: Bool
    
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
                    
                    if let tempCharacter = viewModel.tempCharacter {
                        
                        NavigationLink {
                            CharacterDetailsView(viewModel: tempCharacter)
                        } label: {
                            GridElementView(viewModel: tempCharacter)
                        }
                        
                    }
                    
                    ForEach(viewModel.searchResults(), id: \.id) { characterDetailViewModel in
                        
                        NavigationLink {
                            CharacterDetailsView(viewModel: characterDetailViewModel)
                        } label: {
                            GridElementView(viewModel: characterDetailViewModel)
                            .onAppear {
                                viewModel.loadNextPageIfNeeded(currentRow: characterDetailViewModel)
                            }
                        }
                    }
                }
                .animation(.default, value: viewModel.searchText)
                
            }
        }
        .navigationTitle(title)
        .toolbarColorScheme(.light, for: .navigationBar)
        .toolbar {
            if showButton {
                ToolbarItem(placement: .navigationBarLeading) {
                    MenuButtons(showMenu: $showMenu)
                }
            }
        }
        .toolbarBackground(
            Color.yellow,
            for: .navigationBar
        )
        
        .task {
            await viewModel.fetchInfo()
            await viewModel.fetchCharacters(page: 1)
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


struct GridElementView: View {
    let viewModel: CharacterDetailsViewModel
    
    var body: some View {
        VStack {
            CharacterImage(
                imageURL: viewModel.imageData,
                imageSize: CGSize(width: 150, height: 150),
                cornerRadius: 20,
                shadowIsOn: true,
                defaultImage: viewModel.defaultImage
            )
            Text(viewModel.characterName)
                .font(.headline)
        }
    }
}

struct GridElementView_Previews: PreviewProvider {
    static var previews: some View {
        GridElementView(viewModel: CharacterDetailsViewModel(character: Character.getCharacter()))
    }
}
