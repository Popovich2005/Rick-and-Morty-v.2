//
//  NetworkManager.swift
//  Rick and Morty v.2
//
//  Created by Алексей Попов on 19.03.2024.
//

import Foundation
import Alamofire

enum Link {
    case characterURL
    
    var url: URL {
        switch self {
        case .characterURL:
            return URL(string: "https://rickandmortyapi.com/api/character")!
        }
    }
}

final class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
//    func fetchData(from url: String, completion: @escaping(Result<Data, AFError>) -> Void) {
//        AF.request(url)
//            .validate()
//            .responseData { response in
//                switch response.result {
//                case .success(let data):
//                    completion(.success(data))
//                case .failure(let error):
//                    print(error)
//                    completion(.failure(error))
//                }
//            }
//    }
    
//    func fetchAllCharacter(
//        from url: URL,
//        completion: @escaping(Result<AllCharacter, NetworkError>) -> Void) {
//        URLSession.shared.dataTask(with: url) { data, _, error in
//            guard let data else {
//                print(error?.localizedDescription ?? "No error description")
//                completion(.failure(.noData))
//                return
//            }
//            do {
//                let dataModel = try JSONDecoder().decode(AllCharacter.self, from: data)
//                DispatchQueue.main.async {
//                    completion(.success(dataModel))
//                    print(dataModel)
//                }
//            } catch {
//                completion(.failure(.decodingError))
//            }
//        }.resume()
//    }
    
    func fetchAllCharacter(from url: URL, completion: @escaping(Result<[Character], AFError>) -> Void) {
        AF.request(url)
            .validate()
            .responseJSON { dataResponse in
                switch dataResponse.result {
                case .success(let value):
                    let allCharacter = Character.getAllCharacter(from: value)
                    completion(.success(allCharacter))
                case .failure(let error):
                    print(error)
                    completion(.failure(error))
                }
            }
    }
}
