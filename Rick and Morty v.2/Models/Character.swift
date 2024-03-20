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
    let gender: String
    let origin: Location
    let location: Location
    let image: URL
    
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
}

struct Location: Decodable {
    let name: String
    let url: String
}

struct Origin: Decodable {
    let name: String
    let url: String
}

struct AllCharacter: Decodable {
    let results: [Character]
}


