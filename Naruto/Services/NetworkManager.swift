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
    case noConnection
}

final class NetworkManager {
    let url = "https://www.narutodb.xyz/api/"
    static let shared = NetworkManager()
    
    let networkMonitor = NetworkMonitor()
    
    private init() {}
    
    func fetch<T: Decodable>(_ type: T.Type, from url: String) async throws -> T {
        guard let url = URL(string: url) else {
            throw NetworkError.invalidURL
        }
        
        // Попытка получить кэшированный ответ
        if let cachedResponse = URLCache.shared.cachedResponse(for: URLRequest(url: url)){
            
            let data = cachedResponse.data
            
            let decoder = JSONDecoder()
            do {
                let dataModel = try decoder.decode(T.self, from: data)
                return dataModel
            } catch {
                print("Ошибка декодирования кэшированных данных: \(error)")
                throw NetworkError.decodingError
            }
        }
        
        // Если данных нет в кэше, выполним сетевой запрос
        
        if !networkMonitor.isConnected {
            throw NetworkError.noConnection
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoder = JSONDecoder()
        
        do {
            
            let response = HTTPURLResponse(
                url: url,
                statusCode: 200,
                httpVersion: "HTTP/1.1",
                headerFields: nil
            )
            
            let cachedResponse = CachedURLResponse(
                response: response!,
                data: data
            )
            
            URLCache.shared.storeCachedResponse(cachedResponse, for: URLRequest(url: url))
            
            let dataModel = try decoder.decode(T.self, from: data)
            
            return dataModel
        } catch {
            // Обработка ошибки декодирования
            print("Ошибка декодирования: \(error)")
            throw NetworkError.decodingError
        }
    }

}

enum API: String {
    case characters = "character"
    case tailedBeast = "tailed-beast"
    case akatsuki = "akatsuki"
    case kara = "kara"
    case teams = "team"
    case village = "village"
    case kekkeiGenkai = "kekkei-genkai"
    case clans = "clan"
}
