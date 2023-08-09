//
//  TailedBeastsListView.swift
//  Naruto
//
//  Created by Khusain on 03.08.2023.
//

import SwiftUI

struct TailedBeastsListView: View {
    var body: some View {
        let tailedBeastsListViewModel = CharacterListViewModel<TailedBeastsData>(t: TailedBeastsData.self, url: API.tailedBeast)
        
        NavigationView {
            GridView(viewModel: tailedBeastsListViewModel, title: "Tailed Beasts")
        }
    }
}

struct TailedBeastsListView_Previews: PreviewProvider {
    static var previews: some View {
        TailedBeastsListView()
    }
}
