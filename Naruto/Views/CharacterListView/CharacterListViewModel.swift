//
//  CharacterListViewModel.swift
//  Naruto
//
//  Created by Khusain on 31.07.2023.
//

import Foundation

class CharacterListViewModel<T: DataResponseProtocol>: ObservableObject {
    @Published var rows: [CharacterDetailsViewModel] = []
    @Published var isLoading = false
    @Published var loadedData = false
    @Published var searchText = ""
    @Published var tempCharacter: CharacterDetailsViewModel? = nil
    
    var defaultImage: String? = nil
    var searchTask: Task<Void, Never>? = nil
    var fetch = true
    
    var currentPage = 1
    var totalCharacters: Int? = nil
    var loadedCharacters = 0
    
    var pageSize: Int? = nil
    var t: T.Type? = nil
    var url: String? = nil
    
    
    init(t: T.Type, url: API) {
        self.t = t
        self.url = NetworkManager.shared.url + url.rawValue
    }
    
    init(characters: [Character], defaultImage: String) {
        rows = characters.map {
            CharacterDetailsViewModel(character: $0, defaultImage: defaultImage)
        }
        
        fetch = false
    }
    
    func searchResults() -> [CharacterDetailsViewModel] {
        if searchText.isEmpty {
            return rows
        } else {
            return rows.filter { $0.characterName.contains(searchText) }
        }
    }
    
    func fetchInfo() async {
        do {
            if !fetch {
                return
            }
            
            guard let t,
                  let url
            else {
                return
            }
            
            if totalCharacters == nil,
               pageSize == nil,
               defaultImage == nil {
                
                await MainActor.run {
                    loadedData = true
                }
                
                let info = try await NetworkManager.shared.fetch(
                    t,
                    from: url
                )
                
                totalCharacters = info.totalData
                pageSize = info.pageSize
                defaultImage = info.defaultImage
                
                await MainActor.run{
                    loadedData = false
                }
            }
            
        } catch {
            print(error)
        }
    }
    
    func fetchCharacters(page: Int) async {
        do {
            if let pageSize,
               loadedCharacters >= pageSize * currentPage || !fetch {
                return
            }
            
            guard let t,
                  let url
            else {
                return
            }
            
            
            let urlWithPage = "\(url)?page=\(page)"
            let characters = try await NetworkManager.shared.fetch(
                t,
                from: urlWithPage
            )
            
            loadedCharacters += characters.pageSize
            
            guard let characters = characters.data as? [Character] else {
                return
            }
            
            await MainActor.run {
                guard let defaultImage else {
                    return
                }
                
                if page == 1 {
                    rows = characters.map { CharacterDetailsViewModel(character: $0, defaultImage: defaultImage) }
                } else {
                    rows.append(contentsOf: characters.map {
                        CharacterDetailsViewModel(character: $0, defaultImage: defaultImage)
                    })
                }
                isLoading = false
            }
        } catch {
            print(error)
        }
    }
    
    func fetchSearch() async {
        if searchText.isEmpty || rows.contains(where: { $0.characterName.contains(searchText)}) || !fetch {
            return
        }
        
        guard let url else {
            return
        }
        do {
            loadedData = true
            let urlWIthSearch = "\(url)/search?name=\(searchText.replacingOccurrences(of: " ", with: "%20"))"
            let character = try await NetworkManager.shared.fetch(
                Character.self,
                from: urlWIthSearch
            )
            await MainActor.run {
                guard let defaultImage else {
                    print("Default image not found")
                    return
                }
                
                tempCharacter = CharacterDetailsViewModel(character: character, defaultImage: defaultImage)
                loadedData = false
            }
        } catch {
            print(error)
        }
    }
    
    func sleepFetchSearch() {
        if !fetch {
            return
        }
        
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
        if searchText.isEmpty && tempCharacter != nil {
            tempCharacter = nil
        }
    }
    
    func loadNextPageIfNeeded(currentRow: CharacterDetailsViewModel) {
        if rows.last == currentRow {
            guard let pageSize else {
                return
            }
            
            let totalLoadedCharacters = currentPage * pageSize
            if totalLoadedCharacters < totalCharacters ?? 0 {
                isLoading = true
                currentPage += 1
                Task {
                    await fetchCharacters(page: currentPage)
                    print("Current \(currentPage)")
                }
            }
        }
    }
    
}
