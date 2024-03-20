//
//  NetworkManager.swift
//  Rick and Morty v.2
//
//  Created by Алексей Попов on 19.03.2024.
//

import Foundation

enum Link {
    case characterURL
    
    var url: URL {
        switch self {
        case .characterURL:
            return URL(string: "https://rickandmortyapi.com/api/character")!
        }
    }
}
enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

final class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchImage(from url: URL, completion: @escaping(Result<Data, NetworkError>) -> Void) {
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: url) else {
                completion(.failure(.noData))
                return
            }
            DispatchQueue.main.async {
                completion(.success(imageData))
            }
        }
    }
    
    func fetchAllCharacter(
        from url: URL,
        completion: @escaping(
            Result<AllCharacter, NetworkError>
        ) -> Void
    ) {
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data else {
                print(error?.localizedDescription ?? "No error description")
                completion(.failure(.noData))
                return
            }
            do {
                let dataModel = try JSONDecoder().decode(AllCharacter.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(dataModel))
                    print(dataModel)
                }
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
}
