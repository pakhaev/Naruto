//
//  GenericListViewModel.swift
//  Naruto
//
//  Created by Khusain on 01.09.2023.
//

import Foundation

final class GenericListViewModel<T: DataResponseProtocol>: ObservableObject {
    
    func getViewModelType(dataType: T.Type, url: API) -> CommonViewModel<T> {
        
        var viewModel: CommonViewModel<T> = CommonViewModel()
        
        print(dataType.self)
        
        if dataType == CharactersData.self ||
           dataType == TailedBeastsData.self ||
           dataType == KaraData.self ||
           dataType == AkatsukiData.self {
            print("Im here")
            viewModel = CharacterListViewModel<T>(type: dataType, url: url)
        } else if dataType == ClansData.self ||
                  dataType == VillagesData.self ||
                  dataType == KekkeiGenkaiData.self ||
                  dataType == TeamsData.self {
            viewModel = BlockListViewModel<T>(type: dataType, url: url)
        }
        
        return viewModel
    }
}
