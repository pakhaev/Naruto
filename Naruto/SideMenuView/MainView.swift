//
//  MainView.swift
//  Naruto
//
//  Created by Khusain on 08.08.2023.
//

import SwiftUI

struct MainView: View {
    @State var selectedTab = 0
    @State var showMenu = false
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color("Yellow"), Color("Orange")]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            
            ScrollView {
                SideMenuView(selectedTab: $selectedTab)
            }
            
            ZStack {
                BackgroundSubview(
                    showMenu: showMenu,
                    xOffset: -25,
                    verticalPadding: 30
                )
                
                BackgroundSubview(
                    showMenu: showMenu,
                    xOffset: -50,
                    verticalPadding: 60
                )
                
                CustomTabView(selectedTab: $selectedTab)
                    .cornerRadius(showMenu ? 15 : 0)
                    .onTapGesture {
                        if showMenu {
                            withAnimation(.spring()) {
                                showMenu.toggle()
                            }
                        }
                    }
            }
            .scaleEffect(showMenu ? 0.84 : 1)
            .offset(x: showMenu ? getRect().width - 150 : 0)
            .ignoresSafeArea()
            .overlay(MenuButtons(showMenu: $showMenu), alignment: .topLeading)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

extension View {
    func getRect() -> CGRect {
        UIScreen.main.bounds
    }
}


struct BackgroundSubview: View {
    let showMenu: Bool
    let xOffset: CGFloat
    let verticalPadding: CGFloat
    
    
    var body: some View {
        Color.white
            .opacity(0.5)
            .cornerRadius(showMenu ? 15 : 0)
            .shadow(color: .black.opacity(0.07), radius: 5, x: -5, y: 0)
            .offset(x: showMenu ? xOffset : 0)
            .padding(.vertical, verticalPadding)
    }
}
