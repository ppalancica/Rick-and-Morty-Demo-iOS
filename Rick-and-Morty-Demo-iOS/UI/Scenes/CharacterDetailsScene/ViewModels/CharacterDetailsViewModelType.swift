//
//  CharacterViewModelType.swift
//  Rick-and-Morty-Demo-iOS
//
//  Created by Palancica Pavel on 16.02.2023.
//

import Foundation

protocol CharacterDetailsViewModelType {
    
    var selectedCharacterViewModel: CharacterViewModelType { get }
    
    var navigationTitle: String { get }
}

struct CharacterDetailsViewModel: CharacterDetailsViewModelType {
    
    let selectedCharacterViewModel: CharacterViewModelType

    var navigationTitle: String {
        return selectedCharacterViewModel.name
    }
    
    init(characterViewModel: CharacterViewModelType) {
        self.selectedCharacterViewModel = characterViewModel
    }
}
