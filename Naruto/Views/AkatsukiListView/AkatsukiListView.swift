//
//  AkatsukiListView.swift
//  Naruto
//
//  Created by Khusain on 10.08.2023.
//

import SwiftUI

struct AkatsukiListView: View {
    var body: some View {
        let akatsukiListViewModel = CharacterListViewModel<Akatsuki>(t: Akatsuki.self, url: API.akatsuki)
        
        NavigationView {
            GridView(viewModel: akatsukiListViewModel, title: "Akatsuki")
        }
    }
}

struct AkatsukiListView_Previews: PreviewProvider {
    static var previews: some View {
        AkatsukiListView()
    }
}
