//
//  GenericListView.swift
//  Naruto
//
//  Created by Khusain on 01.09.2023.
//

import SwiftUI

struct GenericListView<T: DataResponseProtocol>: View {
    
    @StateObject private var networkMonitor = NetworkMonitor()
    @StateObject private var viewModel = GenericListViewModel<T>()
    
    let dataType: T.Type
    let url: API
    let title: String
    
    @Binding var showMenu: Bool
    @State private var showNetworkAlert = false
    
    var body: some View {
        NavigationView {
            GenericGridView(
                viewModel: viewModel.getViewModelType(
                    dataType: dataType,
                    url: url
                ),
                title: title,
                showButton: true,
                showMenu: $showMenu
            )
        }
        .onAppear {
            withAnimation(.spring()) {
                showMenu = false
            }
            showNetworkAlert = networkMonitor.isConnected == false
        }
        .onChange(of: networkMonitor.isConnected) { connection in
            showNetworkAlert = connection == false
        }
        .alert(
            "Network connection seems to be offline.",
            isPresented: $showNetworkAlert
        ) {}
    }
}
struct GenericListView_Previews: PreviewProvider {
    static var previews: some View {
        NarutoView()
    }
}
