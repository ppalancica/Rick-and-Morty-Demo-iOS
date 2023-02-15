//
//  CharacterViewModelType.swift
//  Rick-and-Morty-Demo-iOS
//
//  Created by Palancica Pavel on 15.02.2023.
//

import Foundation

protocol CharacterViewModelType {
    
    init(character: Character)
}

struct CharacterViewModel: CharacterViewModelType {
    
    let character: Character
    
    init(character: Character) {
        self.character = character
    }
}
