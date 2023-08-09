//
//  CharacterListViewModel.swift
//  Naruto
//
//  Created by Khusain on 31.07.2023.
//

import Foundation

final class CharacterListViewModel<T: DataResponseProtocol>: ObservableObject {
    @Published var rows: [CharacterDetailsViewModel] = []
    @Published var isLoading = false
    @Published var searchText = ""
    @Published var tempCharacter: CharacterDetailsViewModel?
    
    private var currentPage = 1
    private var totalCharacters: Int?
    
    private let pageSize = 20
    private let t: T.Type
    private let url: API
    
    init(t: T.Type, url: API) {
        self.t = t
        self.url = url
    }
    
    var searchTask: Task<Void, Never>?
    
    func searchResults() -> [CharacterDetailsViewModel] {
        if searchText.isEmpty {
            return rows
        } else {
            return rows.filter { $0.characterName.contains(searchText) }
        }
    }
    
    func fetchCharacters(page: Int) async {
        do {
            
            let url = "\(url.rawValue)?page=\(page)"
            print("Url: \(url)")
            let characters = try await NetworkManager.shared.fetch(
                t,
                from: url
            )
            
            totalCharacters = characters.totalData
            
            await MainActor.run {
                if page == 1 {
                    rows = characters.data.map { CharacterDetailsViewModel(character: $0) }
                } else {
                    rows.append(contentsOf: characters.data.map {
                        CharacterDetailsViewModel(character: $0)
                    })
                }
                isLoading = false
            }
        } catch {
            print(error)
        }
    }
    
    func fetchSearch() async {
        do {
            if searchText.isEmpty || rows.contains(where: { $0.characterName.contains(searchText)}) {
                return
            }
            print("\(API.characters.rawValue)/search?name=\(searchText.replacingOccurrences(of: " ", with: "%20"))")
            let url = "\(API.characters.rawValue)/search?name=\(searchText.replacingOccurrences(of: " ", with: "%20"))"
            let character = try await NetworkManager.shared.fetch(
                Character.self,
                from: url
            )
            await MainActor.run {
                tempCharacter = CharacterDetailsViewModel(character: character)
            }
        } catch {
            print(error)
        }
    }
    
    func sleepFetchSearch() {
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
            
            let totalLoadedCharacters = currentPage * pageSize
            print(totalLoadedCharacters)
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
