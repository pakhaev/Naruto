//
//  CharactersDetailsView.swift
//  Naruto
//
//  Created by Khusain on 31.07.2023.
//

import SwiftUI

struct CharacterDetailsView: View {
    @StateObject var viewModel: CharacterDetailsViewModel
    
    var body: some View {
        ScrollView {
            VStack {
                CharacterImage(
                    imageURL: viewModel.imageData,
                    imageSize: CGSize(width: 250, height: 250),
                    cornerRadius: 20,
                    shadowIsOn: true
                )
                
                
                Text(viewModel.debut)
                    .font(.headline)
                
                Text(viewModel.jutsu)
                    .font(.headline)
                
                Text(viewModel.personal)
                Spacer()
            }
        }
        .navigationTitle(viewModel.characterName)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct CharactersDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterDetailsView(viewModel: CharacterDetailsViewModel(character: Character.getCharacter()))
    }
}
