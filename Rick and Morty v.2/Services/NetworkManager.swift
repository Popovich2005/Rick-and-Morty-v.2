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
            return URL(string: "https://rickandmortyapi.com/api/character/")!
        }
    }
}

final class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchData(from url: String, completion: @escaping(Result<Data, AFError>) -> Void) {
        AF.request(url)
            .validate()
            .responseData { response in
                switch response.result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    print(error)
                    completion(.failure(error))
                }
            }
    }
    
    func fetchAllCharacter(from url: URL, completion: @escaping(Result<AllCharacter, AFError>) -> Void) {
        AF.request(url)
            .validate()
            .responseJSON { dataResponse in
                switch dataResponse.result {
                case .success(let value):
                    let allCharacter = AllCharacter.getAllCharacter(from: value)
                    completion(.success(allCharacter))
                    print(allCharacter)
                case .failure(let error):
                    print(error)
                    completion(.failure(error))
                }
            }
    }
}
