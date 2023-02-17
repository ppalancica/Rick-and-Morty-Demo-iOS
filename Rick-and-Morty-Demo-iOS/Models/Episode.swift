//
//  Episode.swift
//  Rick-and-Morty-Demo-iOS
//
//  Created by Palancica Pavel on 16.02.2023.
//

import Foundation

struct Episode: Codable {
    let id: Int
    let name: String
    let charactersUrls: [String]
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case charactersUrls = "characters"
    }
}
