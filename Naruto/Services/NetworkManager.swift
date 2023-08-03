//
//  NetworkManager.swift
//  Naruto
//
//  Created by Khusain on 31.07.2023.
//

import Foundation

enum NetworkError: Error {
    case noData
    case invalidURL
    case decodingError
    case noImage
    case typeMismatch
}

final class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetch<T: Decodable>(_ type: T.Type, from url: String) async throws -> T {
        guard let url = URL(string: url) else {
            throw NetworkError.invalidURL
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoder = JSONDecoder()
        
//        guard let dataModel = try? decoder.decode(T.self, from: data) else {
//            throw NetworkError.decodingError
//        }
//        return dataModel
        
        do {
            let dataModel = try decoder.decode(T.self, from: data)
            return dataModel
        } catch {
            // Обработайте ошибку декодирования
            print("Ошибка декодирования: \(error)")
            throw NetworkError.decodingError
        }
    }
}

enum API: String {
    case characters = "https://api.narutodb.xyz/character"
    case tailedBeast = "https://api.narutodb.xyz/tailed-beast"
    case search = "https://api.narutodb.xyz/character/search"
}
