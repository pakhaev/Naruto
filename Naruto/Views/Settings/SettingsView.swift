//
//  SettingsView.swift
//  Naruto
//
//  Created by Khusain on 22.08.2023.
//

import SwiftUI

struct SettingsView: View {
    @StateObject var viewModel = SettingsViewModel()
    @State private var showPopup = false
    
    var body: some View {
        NavigationView {
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
            }
            .task {
                await viewModel.getImageStorageSize()
            }
            .navigationTitle("Settings")
        }
        .overlay(
            viewModel.popupView()
                .position(x: UIScreen.main.bounds.width - 200, y: -250)
        )
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
