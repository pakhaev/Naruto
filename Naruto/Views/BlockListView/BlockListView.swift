//
//  BlockListView.swift
//  Naruto
//
//  Created by Khusain on 29.08.2023.
//

import SwiftUI

struct BlockListView<T: DataResponseProtocol>: View {
    
    @StateObject var viewModel: CommonViewModel<T>
    
    @Binding var showMenu: Bool
    
    var body: some View {
        if let tempBoxing = viewModel.tempData {
            NavigationLink {
                GenericGridView<CharactersData>(
                    viewModel: CharacterListViewModel(
                        characters: tempBoxing.characters
                    ),
                    title: "Characters",
                    showButton: false,
                    showMenu: $showMenu
                )
                
            } label: {
                BoxElementView(
                    image: viewModel.defaultImage,
                    name: tempBoxing.name
                )
            }
        }
        
        ForEach(viewModel.search(), id:\.id) { newValue in
            NavigationLink {
                
                GenericGridView<CharactersData>(
                    viewModel: CharacterListViewModel(
                        characters: newValue.characters
                    ),
                    title: "Characters",
                    showButton: false,
                    showMenu: $showMenu
                )
                
            } label: {
                BoxElementView(
                    image: viewModel.defaultImage,
                    name: newValue.name
                )
                .onAppear {
                    viewModel.loadNextPageIfNeeded(currentRowId: newValue.id)
                }
            }
        }
    }
}

struct BoxElementView: View {
    let image: String
    let name: String
    
    
    var body: some View {
        VStack {
            Image(image)
                .resizable()
                .frame(width: 150, height: 150)
                .cornerRadius(20)
            Text(name)
                .font(.headline)
        }
    }
}

struct GridBoxView_Previews: PreviewProvider {
    static var previews: some View {
        NarutoView()
    }
}
