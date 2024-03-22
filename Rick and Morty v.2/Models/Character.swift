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
    
    init(
        name: String,
        status: String,
        species: String,
        type: String,
        gender: String,
        origin: Location,
        location: Location,
        image: String
    ) {
        self.name = name
        self.status = status
        self.species = species
        self.type = type
        self.gender = gender
        self.origin = location
        self.location = location
        self.image = image
    }
    
    init(characterDetails: [String: Any]) {
        name = characterDetails["name"] as? String ?? ""
        status = characterDetails["status"] as? String ?? ""
        species = characterDetails["species"] as? String ?? ""
        type = characterDetails["type"] as? String ?? ""
        gender = characterDetails["gender"] as? String ?? ""
        origin = characterDetails["origin"] as? Location ?? Location.init(name: "", url: "")
        location = characterDetails["location"] as? Location ?? Location.init(name: "", url: "")
        image = characterDetails["image"] as? String ?? ""
    }
    
    static func getAllCharacter(from value: Any) -> [Character] {
        guard let CharacterDetails = value as? [[String: Any]] else { return [] }
        return CharacterDetails.map { Character(characterDetails: $0) }
    }
}

struct Location: Decodable {
    var name: String
    var url: String
    
    init(name: String, url: String) {
        self.name = name
        self.url = url
    }
    
    init(locationDetails: [String: Any]) {
        name = locationDetails["name"] as? String ?? ""
        url = locationDetails["URl"] as? String ?? ""
    }
}

struct AllCharacter: Decodable {
    let results: [Character]
    
    init(results: [Character]) {
        self.results = results
    }
    
    init(allCharacterDetails: [String: Any]) {
        results = allCharacterDetails["results"] as? [Character] ?? [Character(
            name: "",
            status: "",
            species: "",
            type: "",
            gender: "",
            origin: Location(name: "", url: ""),
            location: Location(name: "", url: ""),
            image: ""
        )]
    }
    static func getAllCharacter(from value: Any) -> [Character] {
        guard let CharacterDetails = value as? [[String: Any]] else { return [] }
        return CharacterDetails.map { Character(characterDetails: $0) }
    }
}

