//
//  ContentView.swift
//  Naruto
//
//  Created by Khusain on 31.07.2023.
//

import SwiftUI

struct NarutoView: View {
    
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
                SideMenuView(selectedTab: $selectedTab, showMenu: $showMenu)
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
                
                CustomTabView(selectedTab: $selectedTab, showMenu: $showMenu)
                    .cornerRadius(showMenu ? 15 : 0)
            }
            .scaleEffect(showMenu ? 0.84 : 1)
            .offset(x: showMenu ? getRect().width - 150 : 0)
            .ignoresSafeArea()
        }
        .gesture(
            DragGesture(minimumDistance: 10, coordinateSpace: .global).onEnded { value in
                
                let showing: Bool
                
                switch(value.translation.width, value.translation.height) {
                    case (...0, -30...30):
                        showing = false
                    case (0..., -30...30):
                        showing = true
                    default:  showing = false
                }
                withAnimation(.spring()) {
                    showMenu = showing
                }
            }
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NarutoView()
    }
}


extension View {
    func getRect() -> CGRect {
        UIScreen.main.bounds
    }
}
