//
//  GenericListView.swift
//  Naruto
//
//  Created by Khusain on 01.09.2023.
//

import SwiftUI

struct GenericListView<T: DataResponseProtocol>: View {
    
    @StateObject var viewModel = GenericListViewModel<T>()
    
    let dataType: T.Type
    let url: API
    let title: String
    
    @Binding var showMenu: Bool
    
    var body: some View {
        
        NavigationView {
            GenericGridView(
                viewModel: viewModel.getViewModelType(dataType: dataType, url: url),
                title: title,
                showButton: true,
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
struct GenericListView_Previews: PreviewProvider {
    static var previews: some View {
        NarutoView()
    }
}
