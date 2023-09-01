//
//  GenericGridView.swift
//  Naruto
//
//  Created by Khusain on 30.08.2023.
//

import SwiftUI

struct GenericGridView<T: DataResponseProtocol>: View {
    
    @StateObject var viewModel: CommonViewModel<T>
    let title: String
    let showButton: Bool
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
                    
                    if ((viewModel as? CharacterListViewModel) != nil) {
                        CharacterListView(viewModel: viewModel)
                    } else if ((viewModel as? BlockListViewModel) != nil) {
                        BlockListView(viewModel: viewModel, showMenu: $showMenu)
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

struct GenericGridView_Previews: PreviewProvider {
    static var previews: some View {
        NarutoView()
    }
}
