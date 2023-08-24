//
//  CustomTabItemsView.swift
//  Naruto
//
//  Created by Khusain on 09.08.2023.
//

import SwiftUI

struct CustomTabItemsView: View {
    @Binding var selectedTab: Int
    @Namespace var animation
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            
            TabButtonView(
                selectedTab: $selectedTab,
                page: 0,
                image: "characters",
                title: "Characters",
                animation: animation
            )
            
            TabButtonView(
                selectedTab: $selectedTab,
                page: 1,
                image: "clans",
                title: "Clans",
                animation: animation
            )
            
            TabButtonView(
                selectedTab: $selectedTab,
                page: 2,
                image: "villages",
                title: "Villages",
                animation: animation
            )
            
            TabButtonView(
                selectedTab: $selectedTab,
                page: 3,
                image: "genkai",
                title: "Kekkei Genkai",
                animation: animation
            )
            
            TabButtonView(
                selectedTab: $selectedTab,
                page: 4,
                image: "tailed",
                title: "Tailed Beasts",
                animation: animation
            )
            
            TabButtonView(
                selectedTab: $selectedTab,
                page: 5,
                image: "teams",
                title: "Teams",
                animation: animation
            )
            
            TabButtonView(
                selectedTab: $selectedTab,
                page: 6,
                image: "kara",
                title: "Kara",
                animation: animation
            )
            
            TabButtonView(
                selectedTab: $selectedTab,
                page: 7,
                image: "akatsuki",
                title: "Akatsuki",
                animation: animation
            )
            
            TabButtonView(
                selectedTab: $selectedTab,
                page: 8,
                image: "settings",
                title: "Settings",
                animation: animation
            )
        }
        .padding(.leading, -15)
        .padding(.top, 30)
        
    }
}

struct CustomTabItemsView_Previews: PreviewProvider {
    static var previews: some View {
        NarutoView()
    }
}
