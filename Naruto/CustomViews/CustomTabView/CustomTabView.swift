//
//  CustomTabView.swift
//  Naruto
//
//  Created by Khusain on 08.08.2023.
//

import SwiftUI

struct CustomTabView: View {
    @Binding var selectedTab: Int
    @Binding var showMenu: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            VStack {
                switch selectedTab {
                case 0:
                    CharacterListView(
                        dataType: CharactersData.self,
                        url: .characters,
                        title: "Characters",
                        showMenu: $showMenu
                    )
                case 1:
                    BlockListView(
                        dataType: ClansData.self,
                        url: .clans,
                        title: "Clans",
                        defaultImage: "defaultClans",
                        showMenu: $showMenu
                    )
                case 2:
                    BlockListView(
                        dataType: VillagesData.self,
                        url: .village,
                        title: "Villages",
                        defaultImage: "defaultVillages",
                        showMenu: $showMenu
                    )
                case 3:
                    BlockListView(
                        dataType: KekkeiGenkaiData.self,
                        url: .kekkeiGenkai,
                        title: "Kekkei Genkai",
                        defaultImage: "defaultGenkai",
                        showMenu: $showMenu
                    )
                case 4:
                    CharacterListView(
                        dataType: TailedBeastsData.self,
                        url: .tailedBeast,
                        title: "Tailed Beast",
                        showMenu: $showMenu
                    )
                case 5:
                    BlockListView(
                        dataType: TeamsData.self,
                        url: .teams,
                        title: "Teams",
                        defaultImage: "defaultTeams",
                        showMenu: $showMenu
                    )
                case 6:
                    CharacterListView(
                        dataType: KaraData.self,
                        url: .kara,
                        title: "Kara",
                        showMenu: $showMenu
                    )
                case 7:
                    CharacterListView(
                        dataType: AkatsukiData.self,
                        url: .akatsuki,
                        title: "Akatsuki",
                        showMenu: $showMenu
                    )
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
