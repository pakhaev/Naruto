//
//  GridElementView.swift
//  Naruto
//
//  Created by Khusain on 01.08.2023.
//

import SwiftUI

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
