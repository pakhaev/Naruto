//
//  RowView.swift
//  Naruto
//
//  Created by Khusain on 31.07.2023.
//

import SwiftUI

struct RowView: View {
    let viewModel: CharacterDetailsViewModel
    
    var body: some View {
        HStack {
            CharacterImage(
                imageURL: viewModel.imageData,
                imageSize: CGSize(width: 80, height: 80),
                cornerRadius: 10,
                shadowIsOn: false,
                defaultImage: viewModel.defaultImage
            )
            
            Text(viewModel.characterName)
                .font(.headline)
            Spacer()
        }
    }
}

struct RowView_Previews: PreviewProvider {
    static var previews: some View {
        RowView(viewModel: CharacterDetailsViewModel(character: Character.getCharacter(), defaultImage: ""))
    }
}


//
//  NetworkManager.swift
//  Naruto
//
//  Created by Khusain on 31.07.2023.
//

//import Foundation
//
//enum NetworkError: Error {
//    case noData
//    case invalidURL
//    case decodingError
//    case noImage
//    case typeMismatch
//}
//
//final class NetworkManager {
//    let url = "https://www.narutodb.xyz/api/"
//    static let shared = NetworkManager()
//    
//    private init() {}
//    
//    func fetch<T: Decodable>(_ type: T.Type, from url: String) async throws -> T {
//        guard let url = URL(string: url) else {
//            throw NetworkError.invalidURL
//        }
//        
//        let (data, _) = try await URLSession.shared.data(from: url)
//        let decoder = JSONDecoder()
//        
//        
//        do {
//            let dataModel = try decoder.decode(T.self, from: data)
//            return dataModel
//        } catch {
//            // Обработайте ошибку декодирования
//            print("Ошибка декодирования: \(error)")
//            throw NetworkError.decodingError
//        }
//    }
//}
//
//enum API: String {
//    case characters = "character"
//    case tailedBeast = "tailed-beast"
//    case akatsuki = "akatsuki"
//    case kara = "kara"
//    case teams = "team"
//    case village = "village"
//    case kekkeiGenkai = "kekkei-genkai"
//    case clans = "clan"
//}
