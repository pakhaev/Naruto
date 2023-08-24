//
//  SideMenuView.swift
//  Naruto
//
//  Created by Khusain on 08.08.2023.
//

import SwiftUI

struct SideMenuView: View {
    
    @Binding var selectedTab: Int
    @Binding var showMenu: Bool
    @Namespace var animation
    
    var body: some View {
        //Side menu
        VStack(alignment: .leading, spacing: 15) {
//            MenuButtons(showMenu: $showMenu)
            VStack(alignment: .leading, spacing: 6) {
                
                Text("Naruto Info")
                    .font(.title)
                    .fontWeight(.heavy)
                    .padding(.top, 40)
                
                Text("Menu")
                    .font(.title3)
                    .fontWeight(.heavy)
                    .foregroundColor(.white)
            }
            
            CustomTabItemsView(selectedTab: $selectedTab)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }
}

struct SideMenuView_Previews: PreviewProvider {
    static var previews: some View {
        NarutoView()
    }
}
