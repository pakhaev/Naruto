//
//  GridElementView.swift
//  Naruto
//
//  Created by Khusain on 01.08.2023.
//

import SwiftUI

struct GridView<T: DataResponseProtocol>: View {
    @ObservedObject var viewModel: CharacterListViewModel<T>
    let title: String
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]) {
                
                if let tempCharacter = viewModel.tempCharacter {
                    NavigationLink(destination: CharacterDetailsView(viewModel: tempCharacter)) {
                        GridElementView(viewModel: tempCharacter)
                    }
                }
                
                ForEach(viewModel.searchResults(), id: \.id) { characterDetailViewModel in
                    NavigationLink(destination: CharacterDetailsView(viewModel: characterDetailViewModel)) {
                        GridElementView(viewModel: characterDetailViewModel)
                            .onAppear {
                                viewModel.loadNextPageIfNeeded(currentRow: characterDetailViewModel)
                            }
                    } //:NAVIGATIONLINK
                }
            }
            .animation(.default, value: viewModel.searchText)
            .navigationTitle(title)
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


struct GridElementView: View {
    let viewModel: CharacterDetailsViewModel
    
    var body: some View {
        VStack {
            CharacterImage(
                imageURL: viewModel.imageData,
                imageSize: CGSize(width: 150, height: 150),
                cornerRadius: 20,
                shadowIsOn: true
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
