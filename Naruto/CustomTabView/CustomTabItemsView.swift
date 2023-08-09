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
                title: "Home",
                animation: animation
            )
            
            TabButtonView(
                selectedTab: $selectedTab,
                page: 1,
                image: "tailed",
                title: "Notifications",
                animation: animation
            )
            
            TabButtonView(
                selectedTab: $selectedTab,
                page: 2,
                image: "akatsukiKara",
                title: "Help",
                animation: animation
            )
            
            TabButtonView(
                selectedTab: $selectedTab,
                page: 3,
                image: "characters",
                title: "Settings",
                animation: animation
            )
            
            TabButtonView(
                selectedTab: $selectedTab,
                page: 4,
                image: "characters",
                title: "AkatsukiKaraView",
                animation: animation
            )
            
            TabButtonView(
                selectedTab: $selectedTab,
                page: 5,
                image: "characters",
                title: "History",
                animation: animation
            )
            
            TabButtonView(
                selectedTab: $selectedTab,
                page: 6,
                image: "characters",
                title: "Helps",
                animation: animation
            )
        }
        .padding(.leading, -15)
        .padding(.top, 50)
        
    }
}

struct CustomTabItemsView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
