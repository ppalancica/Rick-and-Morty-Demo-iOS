//
//  CharacterViewModel.swift
//  Rick-and-Morty-Demo-iOS
//
//  Created by Palancica Pavel on 15.02.2023.
//

import Foundation

protocol CharacterViewModelType {
    
    init(character: Character, episodeName: String)
    
    var name: String { get }
    var location: String { get }
    var episode: String { get }
    var profileImageUrl: String { get }
}

struct CharacterViewModel: CharacterViewModelType {
    
    let name: String
    let location: String
    let episode: String
    let profileImageUrl: String
    
    init(character: Character, episodeName: String) {
        self.name = character.name
        self.location = character.location.name
        self.profileImageUrl = character.imageUrl
        self.episode = episodeName
    }
}
