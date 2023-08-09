//
//  Home.swift
//  Naruto
//
//  Created by Khusain on 08.08.2023.
//

import SwiftUI

struct CustomTabView: View {
    @Binding var selectedTab: Int
    
    init(selectedTab: Binding<Int>) {
        self._selectedTab = selectedTab
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        VStack(spacing: 0) {
            VStack {
                switch selectedTab {
                case 0:
                    HomePage()
                case 1:
                    Notifications()
                case 2:
                    Help()
                case 3:
                    Settings()
                case 4:
                    AkatsukiKaraView()
                case 5:
                    History()
                case 6:
                    Helps()
                case 7:
                    Helps()
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
        HomePage()
    }
}

struct HomePage: View {
    var body: some View {
        
        NavigationView {
            Text("Home")
                .font(.title)
                .fontWeight(.heavy)
                .foregroundColor(.blue)
                .navigationTitle("Home")
        }
    }
}

struct Helps: View {
    var body: some View {
        NavigationView {
            Text("Helps")
                .font(.title)
                .fontWeight(.heavy)
                .foregroundColor(.blue)
                .navigationTitle("Helps")
        }
    }
}

struct History: View {
    var body: some View {
        NavigationView {
            Text("History")
                .font(.title)
                .fontWeight(.heavy)
                .foregroundColor(.blue)
                .navigationTitle("History")
        }
    }
}

struct Notifications: View {
    var body: some View {
        NavigationView {
            Text("Notifications")
                .font(.title)
                .fontWeight(.heavy)
                .foregroundColor(.blue)
                .navigationTitle("Notifications")
        }
    }
}

struct Settings: View {
    var body: some View {
        NavigationView {
            Text("Settings")
                .font(.title)
                .fontWeight(.heavy)
                .foregroundColor(.blue)
                .navigationTitle("Settings")
        }
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
