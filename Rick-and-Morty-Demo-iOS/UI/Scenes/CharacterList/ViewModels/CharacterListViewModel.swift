//
//  CharacterListViewModel.swift
//  Rick-and-Morty-Demo-iOS
//
//  Created by Palancica Pavel on 15.02.2023.
//

import Foundation

protocol CharacterListViewModelType {
    
    var charactersService: CharactersServiceType { get }
    var viewModels: [CharacterViewModel] { get }
    
    func getAllCharactersViewModels(completion: @escaping (Result<[CharacterViewModel], Error>) -> Void)
    func characterViewModel(at index: Int) -> CharacterViewModel?
}

class CharacterListViewModel: CharacterListViewModelType {
    
    let charactersService: CharactersServiceType
    private(set) var viewModels: [CharacterViewModel] = []
    
    init(charactersService: CharactersServiceType) {
        self.charactersService = charactersService
    }
    
    func getAllCharactersViewModels(completion: @escaping (Result<[CharacterViewModel], Error>) -> Void) {
        charactersService.getAllCharacters { result in
            switch result {
            case .success(let characterResponse):
                let viewModels = characterResponse.results.map(CharacterViewModel.init)
                self.viewModels = viewModels
                completion(.success(viewModels))
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func characterViewModel(at index: Int) -> CharacterViewModel? {
        guard index >= 0 && index < viewModels.count else {
            return nil
        }
        return viewModels[index]
    }
}
