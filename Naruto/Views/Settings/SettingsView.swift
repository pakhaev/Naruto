//
//  SettingsView.swift
//  Naruto
//
//  Created by Khusain on 22.08.2023.
//

import SwiftUI

struct SettingsView: View {
    @StateObject private var viewModel = SettingsViewModel()
    @State private var showPopup = false
    @Binding var showMenu: Bool
    
    var body: some View {
        NavigationView {
            ZStack {
                
                LinearGradient(
                    gradient: Gradient(colors: [Color("Yellow"), Color("Orange")]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                VStack {
                    Text(viewModel.urlCacheMemory)
                        .font(.title2)
                        .fontWeight(.heavy)
                    
                    Text(viewModel.imageCacheMemory)
                        .font(.title2)
                        .fontWeight(.heavy)
                    
                    Button {
                        Task {
                            await viewModel.popupToggle()
                        }
                        
                    } label: {
                        Text("Clear All Caches")
                            .font(.headline)
                            .frame(width: 150, height: 50)
                            .background(.blue)
                            .foregroundColor(.white)
                            .cornerRadius(5)
                            .padding()
                    }
                }
                .onAppear {
                    viewModel.getURLStorageSize()
                    withAnimation(.spring()) {
                        showMenu = false
                    }
                }
                .task {
                    await viewModel.getImageStorageSize()
                }
                .navigationTitle("Settings")
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        MenuButtons(showMenu: $showMenu)
                    }
                }
            }
        }
        .overlay(
            viewModel.popupView()
                .position(x: UIScreen.main.bounds.width - 200, y: -250)
        )
        
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(showMenu: Binding.constant(false))
    }
}
