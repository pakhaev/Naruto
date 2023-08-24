//
//  KaraListView.swift
//  Naruto
//
//  Created by Khusain on 10.08.2023.
//

import SwiftUI

struct KaraListView: View {
    var body: some View {
        let karaListViewModel = CharacterListViewModel<Kara>(t: Kara.self, url: API.kara)
        
        NavigationView {
            GridView(viewModel: karaListViewModel, title: "Kara")
        }
    }
}

struct KaraListView_Previews: PreviewProvider {
    static var previews: some View {
        KaraListView()
    }
}
