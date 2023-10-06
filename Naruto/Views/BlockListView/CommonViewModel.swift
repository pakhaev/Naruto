//
//  CommonViewModel.swift
//  Naruto
//
//  Created by Khusain on 01.09.2023.
//

import Foundation

class CommonViewModel<T: DataResponseProtocol>: ObservableObject {
    @Published var data: [DataModelProtocol] = []
    @Published var tempData: DataModelProtocol?
    
    @Published var isLoadedData = false
    @Published var isLoading = false
    @Published var searchText = ""
    
    var searchTask: Task<Void, Never>? = nil
    var fetch = true
    
    var currentPage = 1
    var totalData: Int? = nil
    var loadedData = 0
    var defaultImage = ""
    var pageSize: Int? = nil
    var type: T.Type? = nil
    var url: String? = nil
    
    func fetchInfo() async {
        do {
            if !fetch {
                return
            }
            
            guard let type,
                  let url
            else {
                return
            }
            
            if totalData == nil,
               pageSize == nil {
                
                await MainActor.run {
                    isLoadedData = true
                }
                
                let info = try await NetworkManager.shared.fetch(
                    type,
                    from: url
                )
                
                totalData = info.totalData
                pageSize = info.pageSize
                defaultImage = info.defaultImage
                
                await MainActor.run{
                    isLoadedData = false
                }
            }
        } catch {
            print(error)
        }
    }
    
    func search() -> [DataModelProtocol] {
        if searchText.isEmpty {
            return data
        } else {
            return data.filter { $0.name.contains(searchText) }
        }
    }
    
    func fetchData(page: Int) async {
        do {
            if let pageSize,
               loadedData >= pageSize * currentPage || !fetch {
                return
            }
            
            guard let type,
                  let url
            else {
                return
            }
            
            let urlWithPage = "\(url)?page=\(page)"
            let loadingData = try await NetworkManager.shared.fetch(
                type,
                from: urlWithPage
            )
            
            loadedData += loadingData.pageSize
            
            await MainActor.run {
                if let characters = loadingData.data as? [Character] {
                    if currentPage == 1 {
                        data = characters.map {
                            CharacterDetailsViewModel(character: $0)
                        }
                    } else if characters.first?.id != data.first?.id {
                        data.append(
                            contentsOf: characters.map {
                                CharacterDetailsViewModel(character: $0)
                            }
                        )
                    }
                } else if let boxing = loadingData.data as? [InfoData] {
                    if currentPage == 1 {
                        data = boxing
                    } else if boxing.first?.id != data.first?.id {
                        data.append(contentsOf: boxing)
                    }
                }
            }
        } catch {
            print(error)
        }
    }
    
    func loadNextPageIfNeeded(currentRowId: Int) {
        guard let pageSize else {
            return
        }
        
        if data.last?.id == currentRowId {
            let totalLoadedCharacters = currentPage * pageSize
            if totalLoadedCharacters < totalData ?? 0 {
                isLoading = true
                currentPage += 1
                Task {
                    await fetchData(page: currentPage)
                }
            }
        }
    }
    
    func sleepFetchSearch() {
    }
    
}
