//
//  Character.swift
//  Rick and Morty v.2
//
//  Created by Алексей Попов on 19.03.2024.
//

import Foundation

struct Character {
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin: Location
    let location: Location
    let image: String
    
    var description: String {
        """
        status: \(status)
        species: \(species)
        type: \(type)
        gender: \(gender)
        origin: \(origin.name)
        location: "\(location.name)"
        """
    }
    
    init(characterDetails: [String: Any]) {
        name = characterDetails["name"] as? String ?? ""
        status = characterDetails["status"] as? String ?? ""
        species = characterDetails["species"] as? String ?? ""
        type = characterDetails["type"] as? String ?? ""
        gender = characterDetails["gender"] as? String ?? ""
        
        let locationDetails = characterDetails["location"] as? [String: String] ?? [:]
        location = Location(locationDetails: locationDetails)
        
        let originDetails = characterDetails["origin"] as? [String: String] ?? [:]
        origin = Location(locationDetails: originDetails)
        
        image = characterDetails["image"] as? String ?? ""
    }
    static func getAllCharacter(from value: Any) -> [Character] {
        guard let value = value as? [String: Any] else { return [] }
        guard let results = value["results"] as? [[String: Any]] else { return [] }
        return results.map { Character(characterDetails: $0) }
    }
}

struct Location {
    let name: String
    let url: String
    
    init(locationDetails: [String: String]) {
        name = locationDetails["name"] ?? ""
        url = locationDetails["URl"] ?? ""
    }
}

//struct AllCharacter: Decodable {
//    let results: [Character]
//
//    static func getAllCharacter(from value: Any) -> AllCharacter {
//        guard let dict = value as? [String: Any],
//              let characters = dict["results"],
//              let characterDetails = characters as? [[String: Any]]
//        else { return AllCharacter(results: []) }
//        
//        return AllCharacter(results: characterDetails.map{ Character(characterDetails: $0)} )
//    }
//}
