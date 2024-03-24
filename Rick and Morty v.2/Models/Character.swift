//
//  Character.swift
//  Rick and Morty v.2
//
//  Created by Алексей Попов on 19.03.2024.
//

import Foundation

struct Character: Decodable {
    let name: String
    let status: String
    let species: String
    let type: String
    var gender: String
    var origin: Location
    var location: Location
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
        origin = Location(
            name: characterDetails["origin"] as? String ?? "",
            url: characterDetails["url"] as? String ?? ""
        )
        location = Location(
            name: characterDetails["location"] as? String ?? "",
            url: characterDetails["url"] as? String ?? ""
        )
        image = characterDetails["image"] as? String ?? ""
    }
}

struct Location: Decodable {
    var name: String
    var url: String
    
    init(name: String, url: String) {
        self.name = name
        self.url = url
    }
    
//    init(locationDetails: [String: Any]) {
//        name = locationDetails["name"] as? String ?? ""
//        url = locationDetails["URl"] as? String ?? ""
//    }
}

struct AllCharacter: Decodable {
    let results: [Character]

    static func getAllCharacter(from value: Any) -> AllCharacter {
        guard let dict = value as? [String: Any],
              let characters = dict["results"],
              let characterDetails = characters as? [[String: Any]]
        else { return AllCharacter(results: []) }
        
        return AllCharacter(results: characterDetails.map{ Character(characterDetails: $0)} )
    }
}
