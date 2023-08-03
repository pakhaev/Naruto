//
//  CharacterListViewModel.swift
//  Naruto
//
//  Created by Khusain on 31.07.2023.
//

import Foundation

final class CharacterListViewModel: ObservableObject {
    @Published var rows: [CharacterDetailsViewModel] = []
    @Published var isLoading = false
    @Published var searchText = ""
    @Published var tempCharacter: CharacterDetailsViewModel?
    
    
    private var currentPage = 1
    private let pageSize = 20
    private var totalCharacters: Int?
    
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
            let url = "\(API.tailedBeast.rawValue)?page=\(page)"
            print("Url: \(url)")
            let characters = try await NetworkManager.shared.fetch(
                TailedBeastsData.self,
                from: url
            )
            
            totalCharacters = characters.totalTailedBeasts
            
            await MainActor.run {
                if page == 1 {
                    rows = characters.tailedBeasts.map { CharacterDetailsViewModel(character: $0) }
                } else {
                    rows.append(contentsOf: characters.tailedBeasts.map {
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
            print("\(API.search.rawValue)?name=\(searchText.replacingOccurrences(of: " ", with: "%20"))")
            let url = "\(API.search.rawValue)?name=\(searchText.replacingOccurrences(of: " ", with: "%20"))"
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
            if totalLoadedCharacters < totalCharacters ?? 0 {
                isLoading = true
                currentPage += 1
                Task {
                    await fetchCharacters(page: currentPage)
                }
            }
        }
    }
}
