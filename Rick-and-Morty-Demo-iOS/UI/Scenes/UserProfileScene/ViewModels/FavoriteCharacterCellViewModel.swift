//
//  FavoriteCharacterCellViewModel.swift
//  Rick-and-Morty-Demo-iOS
//
//  Created by Palancica Pavel on 19.02.2023.
//

import Foundation

protocol FavoriteCharacterCellViewModelType {
    
    init(character: Character, episode: Episode)
    
    var characterId: Int { get }
    var name: String { get }
    var episode: Episode { get }
    var profileImageUrl: String { get }
}

struct FavoriteCharacterCellViewModel: FavoriteCharacterCellViewModelType {
    
    var characterId: Int
    let name: String
    let episode: Episode
    let profileImageUrl: String
    
    init(character: Character, episode: Episode) {
        self.characterId = character.id
        self.name = character.name
        self.episode = episode
        self.profileImageUrl = character.imageUrl
    }
}
