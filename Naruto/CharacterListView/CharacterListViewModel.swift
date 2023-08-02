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
    
    
    private var currentPage = 1
    private let pageSize = 20
    private let totalCharacters = 1431
    
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
            let characters = try await NetworkManager.shared.fetch(
                CharactersData.self,
                from: "\(API.characters.rawValue)?page=\(page)"
            )
            
            await MainActor.run {
                if page == 1 {
                    rows = characters.characters.map { CharacterDetailsViewModel(character: $0) }
                } else {
                    rows.append(contentsOf: characters.characters.map {
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
            
            print("\(API.search.rawValue)?name=\(searchText.replacingOccurrences(of: " ", with: "%20"))")
            let url = "\(API.search.rawValue)?name=\(searchText.replacingOccurrences(of: " ", with: "%20"))"
            let character = try await NetworkManager.shared.fetch(
                Character.self,
                from: url
            )
            await MainActor.run {
                rows.append(CharacterDetailsViewModel(character: character))
            }
        } catch {
            print(error)
        }
    }
    
    func loadNextPageIfNeeded(currentRow: CharacterDetailsViewModel) {
        if rows.last == currentRow {
            let totalLoadedCharacters = currentPage * pageSize
            if totalLoadedCharacters < totalCharacters {
                isLoading = true
                currentPage += 1
                Task {
                    await fetchCharacters(page: currentPage)
                }
            }
        }
    }
}
