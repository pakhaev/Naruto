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
        ZStack {
            
            LinearGradient(
                gradient: Gradient(colors: [Color("Yellow"), Color("Orange")]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            ScrollView {
                VStack {
                    CharacterImage(
                        imageURL: viewModel.imageData,
                        imageSize: CGSize(width: 250, height: 250),
                        cornerRadius: 20,
                        shadowIsOn: true,
                        defaultImage: viewModel.defaultImage
                    )
                    
                    ForEach(viewModel.data.keys.sorted(), id: \.self) { key in
                        if let value = viewModel.data[key] {
                            HStack {
                                VStack {
                                    HStack {
                                        Text(key)
                                            .font(.headline)
                                            .padding(.leading, 12)
                                            .foregroundColor(.black)
                                        Spacer()
                                    }
                                    
                                    ForEach(Array(value.enumerated()), id: \.0) { _, newValue in
                                        HStack {
                                            Image(systemName: "checkmark")
                                                .frame(width: 10, height: 10)
                                                .foregroundColor(.black)
                                            
                                            Text(newValue)
                                                .foregroundColor(.black)
                                            Spacer()
                                        }
                                        .padding(.leading, 30)
                                        .padding(.top, 10)
                                    }
                                }
                                .padding([.top, .bottom])
                                .frame(maxWidth: .infinity)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(.black, lineWidth: 2)
                                )
                            }
                            .padding([.leading, .trailing], 17)
                        }
                        
                    }
                }
            }
            .onAppear {
                viewModel.getInfo()
            }
            .navigationTitle(viewModel.name)
        .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct CharactersDetailsView_Previews: PreviewProvider {
    static var previews: some View {
//        CharacterDetailsView(viewModel: CharacterDetailsViewModel(character: Character.getCharacter(), defaultImage: ""))
        NarutoView()
    }
}
