//
//  CharacterViewModel.swift
//  Rick-and-Morty-Demo-iOS
//
//  Created by Palancica Pavel on 15.02.2023.
//

import Foundation

protocol CharacterViewModelType {
    
    init(character: Character, episode: Episode)
    
    var name: String { get }
    var location: String { get }
    var episode: Episode { get }
    var status: String { get }
    var profileImageUrl: String { get }
}

struct CharacterViewModel: CharacterViewModelType {
    
    let name: String
    let location: String
    let episode: Episode
    var status: String
    let profileImageUrl: String
    
    init(character: Character, episode: Episode) {
        self.name = character.name
        self.location = character.location.name
        self.status = character.status
        self.episode = episode
        self.profileImageUrl = character.imageUrl
    }
}
