//
//  CharacterViewModelType.swift
//  Rick-and-Morty-Demo-iOS
//
//  Created by Palancica Pavel on 15.02.2023.
//

import Foundation

protocol CharacterViewModelType {
    
    init(character: Character)
    
    var name: String { get }
    var location: String { get }
    var profileImageUrl: String { get }
}

struct CharacterViewModel: CharacterViewModelType {
    
    let character: Character
    
    var name: String
    var location: String
    var profileImageUrl: String
    
    init(character: Character) {
        self.character = character
        self.name = character.name
        self.location = character.location.name
        self.profileImageUrl = character.image
    }
}
