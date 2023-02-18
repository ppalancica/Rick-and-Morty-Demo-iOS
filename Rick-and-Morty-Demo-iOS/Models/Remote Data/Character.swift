//
//  Character.swift
//  Rick-and-Morty-Demo-iOS
//
//  Created by Palancica Pavel on 15.02.2023.
//

import Foundation

struct Character: Codable {
    let id: Int
    let name: String
    let status: String
    let location: Location
    let imageUrl: String
    let episodes: [String]
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case status
        case location
        case imageUrl = "image"
        case episodes = "episode"
    }
}
