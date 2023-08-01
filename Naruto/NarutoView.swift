//
//  ContentView.swift
//  Naruto
//
//  Created by Khusain on 31.07.2023.
//

import SwiftUI

struct NarutoView: View {
    var body: some View {
        
        TabView {
            CharacterListView()
                .tabItem {
                    Label("Characters", systemImage: "person.fill")
                }
            
            ClansListView()
                .tabItem {
                    Label("Clans", systemImage: "person.3.fill")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NarutoView()
    }
}
