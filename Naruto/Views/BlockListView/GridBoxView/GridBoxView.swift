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
    @Binding var showMenu: Bool
    
    var body: some View {
        ScrollView {
            if viewModel.isLoadedData {
                HStack {
                    Spacer()
                    
                    ProgressView("Loading...")
                        .progressViewStyle(CircularProgressViewStyle())
                        .padding()
                    
                    Spacer()
                }
            } else {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]) {
                    
                    //Первая разница
                    if let tempBoxing = viewModel.tempData {
                        NavigationLink {
                            GridView<CharactersData>(
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
                    
                    //Вторая разница
                    ForEach(viewModel.search(), id:\.id) { newValue in
                        NavigationLink {
                            GridView<CharactersData>(
                                viewModel: CharacterListViewModel(
                                    characters: newValue.characters
                                ),
                                title: "Characters",
                                showButton: false,
                                showMenu: Binding.constant(false)
                            )
                            
                        } label: {
                            BoxElementView(
                                image: viewModel.defaultImage,
                                name: newValue.name
                            )
                            .onAppear {
                                viewModel.loadNextPageIfNeeded(currentRowName: newValue.name)
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
            ToolbarItem(placement: .navigationBarLeading) {
                MenuButtons(showMenu: $showMenu)
            }
        }
        .toolbarBackground(
            Color.yellow,
            for: .navigationBar
        )
        
        .task {
            await viewModel.fetchInfo()
            await viewModel.fetchData(page: 1)
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
        }
    }
    
}

struct GridBoxView_Previews: PreviewProvider {
    static var previews: some View {
        NarutoView()
    }
}
