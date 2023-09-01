//
//  CharacterListViewModel.swift
//  Naruto
//
//  Created by Khusain on 31.07.2023.
//

import Foundation

final class CharacterListViewModel<T: DataResponseProtocol>: CommonViewModel<T> {
    
    init(type: T.Type, url: API) {
        super.init()
        
        self.type = type
        self.url = NetworkManager.shared.url + url.rawValue
    }
    
    init(characters: [Character]) {
        super.init()
        data = characters.map {
            CharacterDetailsViewModel(character: $0)
        }
        
        fetch = false
    }
    
    func fetchSearch() async {
        if searchText.isEmpty || data.contains(where: { $0.name.contains(searchText)}) || !fetch {
            return
        }

        guard let url else {
            return
        }
        do {
            isLoading = true
            let urlWIthSearch = "\(url)/search?name=\(searchText.replacingOccurrences(of: " ", with: "%20"))"
            let character = try await NetworkManager.shared.fetch(
                Character.self,
                from: urlWIthSearch
            )

            await MainActor.run {
                tempData = CharacterDetailsViewModel(character: character)
                isLoading = false
            }
        } catch {
            print(error)
        }
    }
    
    override func sleepFetchSearch() {
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
        if searchText.isEmpty && tempData != nil {
            tempData = nil
        }
    }
}
