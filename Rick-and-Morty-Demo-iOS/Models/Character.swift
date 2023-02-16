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
    let image: String
}
