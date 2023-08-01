//
//  RowView.swift
//  Naruto
//
//  Created by Khusain on 31.07.2023.
//

import SwiftUI

struct RowView: View {
    let viewModel: CharacterDetailsViewModel
    
    var body: some View {
        HStack {
            CharacterImage(
                imageURL: viewModel.imageData,
                imageSize: CGSize(width: 80, height: 80),
                cornerRadius: 10,
                shadowIsOn: false
            )
            
            Text(viewModel.characterName)
                .font(.headline)
            Spacer()
        }
    }
}

struct RowView_Previews: PreviewProvider {
    static var previews: some View {
        RowView(viewModel: CharacterDetailsViewModel(character: Character.getCharacter()))
    }
}
