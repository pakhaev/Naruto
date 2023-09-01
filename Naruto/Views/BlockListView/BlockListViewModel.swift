//
//  BlockListViewModel.swift
//  Naruto
//
//  Created by Khusain on 11.08.2023.
//

import Foundation

final class BlockListViewModel<T: DataResponseProtocol>: CharacterListViewModel<T>{
    
    @Published var info: [InfoData] = []
    @Published var characters: [Character] = []
    @Published var tempInfo: InfoData?
    
    
    
    override init(t: T.Type, url: API) {
        super.init(t: t, url: url)
    }
    
    func search() -> [InfoData] {
        if searchText.isEmpty {
            return info
        } else {
            return info.filter { $0.name.contains(searchText) }
        }
    }
    
    func fetchClans(page: Int) async {
        do {
            guard let url,
                  let t
            else {
                return
            }
            
            let urlWithPage = "\(url)?page=\(page)"
            print("url = \(urlWithPage)")
            
            let infoData = try await NetworkManager.shared.fetch(
                t,
                from: urlWithPage
            )
            
            loadedCharacters += infoData.pageSize
            
            guard let infoData = infoData.data as? [InfoData] else {
                print("infoData error")
                return
            }
            
            await MainActor.run {
                if currentPage == 1 {
                    info = infoData
                } else {
                    info.append(contentsOf: infoData)
                }
            }
            
        } catch {
            print(error)
        }
    }
    
    override func fetchSearch() async {
        if searchText.isEmpty || info.contains(where: { $0.name.contains(searchText) }) {
            return
        }
        
        guard let url else {
            return
        }
        do {
            print("\(url)/search?name=\(searchText.replacingOccurrences(of: " ", with: "%20"))")
            let urlWithSearch = "\(url)/search?name=\(searchText.replacingOccurrences(of: " ", with: "%20"))"
            
            let info = try await NetworkManager.shared.fetch(InfoData.self, from: urlWithSearch)
            
            await MainActor.run {
                tempInfo = info
            }
        } catch {
            print(error)
        }
    }
    
    override func sleepFetchSearch() {
        searchTask?.cancel()
        
        searchTask = Task.detached {[unowned self] in
            do {
                try await Task.sleep(nanoseconds: 1_000_000_000)
            } catch {
                print(error)
            }
            
            if Task.isCancelled {
                print("Задача была отменена")
                return
            }
            await self.fetchSearch()
        }
        
        if searchText.isEmpty && tempInfo != nil {
            tempInfo = nil
        }
    }
    
    func loadNextPageIfNeeded(currentRow: String) {
        
        if info.last?.name == currentRow {
            guard let pageSize else {
                return
            }
            
            let totalLoadedInfo = currentPage * pageSize
            print(totalLoadedInfo)
            if totalLoadedInfo < totalCharacters ?? 0 {
                isLoading = true
                currentPage += 1
                Task {
                    await fetchClans(page: currentPage)
                }
            }
        }
    }
    
}
