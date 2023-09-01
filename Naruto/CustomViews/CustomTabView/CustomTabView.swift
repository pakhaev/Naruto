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
                    GenericListView(
                        dataType: CharactersData.self,
                        url: .characters,
                        title: "Characters",
                        showMenu: $showMenu
                    )
                case 1:
                    GenericListView(
                        dataType: ClansData.self,
                        url: .clans,
                        title: "Clans",
                        showMenu: $showMenu
                    )
                case 2:
                    GenericListView(
                        dataType: VillagesData.self,
                        url: .village,
                        title: "Villages",
                        showMenu: $showMenu
                    )
                case 3:
                    GenericListView(
                        dataType: KekkeiGenkaiData.self,
                        url: .kekkeiGenkai,
                        title: "Kekkei Genkai",
                        showMenu: $showMenu
                    )
                case 4:
                    GenericListView(
                        dataType: TailedBeastsData.self,
                        url: .tailedBeast,
                        title: "Tailed Beast",
                        showMenu: $showMenu
                    )
                case 5:
                    GenericListView(
                        dataType: TeamsData.self,
                        url: .teams,
                        title: "Teams",
                        showMenu: $showMenu
                    )
                case 6:
                    GenericListView(
                        dataType: KaraData.self,
                        url: .kara,
                        title: "Kara",
                        showMenu: $showMenu
                    )
                case 7:
                    GenericListView(
                        dataType: AkatsukiData.self,
                        url: .akatsuki,
                        title: "Akatsuki",
                        showMenu: $showMenu
                    )
                case 8:
                    SettingsView(showMenu: $showMenu)
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
        NarutoView()
    }
}
