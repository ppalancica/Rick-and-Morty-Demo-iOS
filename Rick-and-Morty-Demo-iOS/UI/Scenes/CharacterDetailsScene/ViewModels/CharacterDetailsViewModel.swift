//
//  CharacterViewModel.swift
//  Rick-and-Morty-Demo-iOS
//
//  Created by Palancica Pavel on 16.02.2023.
//

import Foundation

protocol CharacterDetailsViewModelType {
    
    init(characterViewModel: CharacterViewModelType,
         charactersService: CharactersServiceType,
         episodesService: EpisodesServiceType)
    
    var selectedCharacterViewModel: CharacterViewModelType { get }
    
    var sameEpisodeCharacters: [CharacterViewModelType] { get }
    func sameEpisodeCharacterViewModel(at index: Int) -> CharacterViewModelType?
    
    var navigationTitle: String { get }
    
    func loadSameEpisodeCharacters(completion: @escaping (Result<[CharacterViewModelType], Error>) -> Void)
}

class CharacterDetailsViewModel: CharacterDetailsViewModelType {
    
    let selectedCharacterViewModel: CharacterViewModelType
    var sameEpisodeCharacters: [CharacterViewModelType] = []
    
    private let charactersService: CharactersServiceType
    private let episodesService: EpisodesServiceType

    var navigationTitle: String {
        return selectedCharacterViewModel.name
    }
    
    required init(characterViewModel: CharacterViewModelType,
         charactersService: CharactersServiceType,
         episodesService: EpisodesServiceType) {
        self.selectedCharacterViewModel = characterViewModel
        self.charactersService = charactersService
        self.episodesService = episodesService
    }
    
    func sameEpisodeCharacterViewModel(at index: Int) -> CharacterViewModelType? {
        guard index >= 0 && index < sameEpisodeCharacters.count else {
            return nil
        }
        return sameEpisodeCharacters[index]
    }
    
    func loadSameEpisodeCharacters(completion: @escaping (Result<[CharacterViewModelType], Error>) -> Void) {
        let group = DispatchGroup()
        sameEpisodeCharacters = []
        
        for urlString in selectedCharacterViewModel.episode.charactersUrls {
            group.enter()
            charactersService.getCharacter(urlString: urlString, completion: { [weak self] characterResult in
                guard let strongSelf = self else { return }
                
                switch characterResult {
                case .success(let character):
                    strongSelf.sameEpisodeCharacters.append(
                        CharacterViewModel(
                            character: character,
                            episode: strongSelf.selectedCharacterViewModel.episode
                        )
                    )
                    break
                case .failure(let error):
                    print(error)
                }
                group.leave()
            })
        }
        
        group.notify(queue: DispatchQueue.global()) {
            DispatchQueue.main.async { [weak self] in
                guard let strongSelf = self else { return }
                completion(.success(strongSelf.sameEpisodeCharacters))
            }
        }
    }
}
