//
//  CustomTabView.swift
//  Naruto
//
//  Created by Khusain on 08.08.2023.
//

import SwiftUI

struct CustomTabView: View {
    @Binding var selectedTab: Int
    
    var body: some View {
        VStack(spacing: 0) {
            VStack {
                switch selectedTab {
                case 0:
                    CharacterListView()
                case 1:
                    ClansListView()
                case 2:
                    Help()
                case 3:
                    Help()
                case 4:
                    TailedBeastsListView()
                case 5:
                    Help()
                case 6:
                    KaraListView()
                case 7:
                    AkatsukiListView()
                case 8:
                    SettingsView()
                default:
                    EmptyView()
                }
            }

            Spacer()
        }
    }
}


struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Help()
    }
}

struct Help: View {
    var body: some View {
        NavigationView {
            Text("Help")
                .font(.title)
                .fontWeight(.heavy)
                .foregroundColor(.blue)
                .navigationTitle("Help")
        }
    }
}
