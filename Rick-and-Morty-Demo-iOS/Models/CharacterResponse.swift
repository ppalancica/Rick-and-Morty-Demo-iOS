//
//  CharacterResponse.swift
//  Rick-and-Morty-Demo-iOS
//
//  Created by Palancica Pavel on 15.02.2023.
//

import Foundation

struct CharacterResponse: Codable {
    let info: Info
    let results: [Character]
}
