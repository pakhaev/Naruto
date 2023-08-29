//
//  BlockListView.swift
//  Naruto
//
//  Created by Khusain on 29.08.2023.
//

import SwiftUI

struct BlockListView<T: DataResponseProtocol>: View {
    
    let dataType: T.Type
    let url: API
    let title: String
    let defaultImage: String
    
    @Binding var showMenu: Bool
    
    var body: some View {
        let viewModel = BlockListViewModel<T>(t: dataType, url: url)

        NavigationView {
            GridBoxView(
                viewModel: viewModel,
                title: title,
                defaultImage: defaultImage,
                showMenu: $showMenu
            )
        }
        .onAppear {
            withAnimation(.spring()) {
                showMenu = false
            }
        }
    }
}

struct BlockListView_Previews: PreviewProvider {
    static var previews: some View {
        BlockListView<ClansData>(
            dataType: ClansData.self,
            url: API.clans,
            title: "Clans",
            defaultImage: "defaultClans", showMenu: Binding.constant(false)
        )
    }
}