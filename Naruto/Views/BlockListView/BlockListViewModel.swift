//
//  BlockListViewModel.swift
//  Naruto
//
//  Created by Khusain on 11.08.2023.
//

final class BlockListViewModel<T: DataResponseProtocol>: CommonViewModel<T>{
    
    init(type: T.Type, url: API) {
        super.init()
        self.type = type
        self.url = NetworkManager.shared.url + url.rawValue
    }
    
    func fetchSearch() async {
        if searchText.isEmpty || data.contains(where: { $0.name.contains(searchText) }) {
            return
        }

        guard let url else {
            return
        }
        do {
            isLoadedData = true
            let urlWithSearch = "\(url)/search?name=\(searchText.replacingOccurrences(of: " ", with: "%20"))"

            let info = try await NetworkManager.shared.fetch(
                InfoData.self,
                from: urlWithSearch
            )

            await MainActor.run {
                tempData = info
                isLoadedData = false
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
        
        if searchText.isEmpty && tempData != nil {
            tempData = nil
        }
    }
}
