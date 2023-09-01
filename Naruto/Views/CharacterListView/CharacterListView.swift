//
//  CharacterListView.swift
//  Naruto
//
//  Created by Khusain on 01.08.2023.
//

import SwiftUI

struct CharacterListView<T: DataResponseProtocol>: View {
    
    @StateObject var viewModel: CommonViewModel<T>
    
    var body: some View {
        if let tempCharacter = viewModel.tempData {
            NavigationLink {
                CharacterDetailsView(viewModel: tempCharacter as! CharacterDetailsViewModel)
            } label: {
                GridElementView(viewModel: tempCharacter as! CharacterDetailsViewModel)
            }
            
        }
        
        ForEach(viewModel.search(), id: \.id) { characterDetailViewModel in
            NavigationLink {
                CharacterDetailsView(viewModel: characterDetailViewModel as! CharacterDetailsViewModel)
            } label: {
                GridElementView(viewModel: characterDetailViewModel as! CharacterDetailsViewModel)
                .onAppear {
                    viewModel.loadNextPageIfNeeded(currentRowName: characterDetailViewModel.name)
                }
            }
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
                shadowIsOn: true,
                defaultImage: viewModel.defaultImage
            )
            Text(viewModel.name)
                .font(.headline)
        }
    }
}

struct GridElementView_Previews: PreviewProvider {
    static var previews: some View {
        GridElementView(viewModel: CharacterDetailsViewModel(character: Character.getCharacter()))
    }
}
