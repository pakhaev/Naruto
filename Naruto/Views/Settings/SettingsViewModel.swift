//
//  SettingsViewModel.swift
//  Naruto
//
//  Created by Khusain on 22.08.2023.
//

import Kingfisher
import SwiftUI


final class SettingsViewModel: ObservableObject {
    @Published var imageCacheMemory = "Image cache is empty"
    @Published var urlCacheMemory = "URL memory cache is empty"
    @Published var showPopup = false
    
    func popupToggle() async {
        await clearAllMemory()
        showPopup.toggle()
        
        do {
            try await Task.sleep(nanoseconds: 2_000_000_000)
            showPopup.toggle()
        } catch {
            print("show popup time error")
        }
    }
    
    @ViewBuilder
    func popupView() -> some View {
        if showPopup {
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Text("Done")
                        .padding()
                        .background(Color.gray)
                        .cornerRadius(10)
                        .foregroundColor(.white)
                        .shadow(radius: 5)
                        .padding(20)
                        .onTapGesture { [unowned self] in
                            showPopup = false
                        }
                }
            }
        }
    }
    
    func clearAllMemory() async {
        // MARK: - Clear KFImage cache
        let cache = ImageCache.default
        
        // Remove all.
        cache.clearMemoryCache()
        cache.clearDiskCache { print("Done") }

        // Remove only expired.
        cache.cleanExpiredMemoryCache()
        cache.cleanExpiredDiskCache { print("Done") }
        
        // MARK: - Clear URLCache
        URLCache.shared.removeAllCachedResponses()
        
        await getImageStorageSize()
    }
    
    
    func getURLStorageSize() {
        let memoryCache = URLCache.shared.currentMemoryUsage
        let urlCache = URLCache.shared.currentDiskUsage
        
        urlCacheMemory = "Memory cache usage: \(formattedSize(Double(memoryCache + urlCache))) MB"
    }
    
    func getImageStorageSize() async {
        ImageCache.default.calculateDiskStorageSize {[unowned self] memory in
            switch memory {
            case .success(let size):
                imageCacheMemory = "Disk cache size: \(formattedSize(Double(size))) MB"
                print("Yes")
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func formattedSize(_ value: Double) -> String {
        String(format: "%.1f", value / 1024 / 1024)
    }
}
