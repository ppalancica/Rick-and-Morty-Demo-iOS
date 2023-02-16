//
//  CharacterListViewModel.swift
//  Rick-and-Morty-Demo-iOS
//
//  Created by Palancica Pavel on 15.02.2023.
//

import Foundation

protocol CharacterListViewModelType {
    
    init(charactersService: CharactersServiceType, episodesService: EpisodesServiceType)
    
    var viewModels: [CharacterViewModel] { get }
    var charactersCount: Int { get }
    
    func getAllCharactersViewModels(completion: @escaping (Result<[CharacterViewModel], Error>) -> Void)
    func characterViewModel(at index: Int) -> CharacterViewModel?
}

class CharacterListViewModel: CharacterListViewModelType {
    
    private let charactersService: CharactersServiceType
    private let episodesService: EpisodesServiceType
    private(set) var viewModels: [CharacterViewModel] = []
    var charactersCount: Int { return viewModels.count }

    required init(charactersService: CharactersServiceType, episodesService: EpisodesServiceType) {
        self.charactersService = charactersService
        self.episodesService = episodesService
    }
    
//    func getAllCharactersViewModels(completion: @escaping (Result<[CharacterViewModel], Error>) -> Void) {
//        charactersService.getAllCharacters { result in
//            switch result {
//            case .success(let characterResponse):
//                let viewModels = characterResponse.results.map(CharacterViewModel.init)
//                self.viewModels = viewModels
//                completion(.success(viewModels))
//            case .failure(let error):
//                print(error)
//            }
//        }
//    }
    
    func getAllCharactersViewModels(completion: @escaping (Result<[CharacterViewModel], Error>) -> Void) {
        let group = DispatchGroup()
        
        charactersService.getAllCharacters { [weak self] result in
            switch result {
            case .success(let characterResponse):
                var episodeUrlToNameMappings: [String: String] = [:]
                
                for character in characterResponse.results {
                    
                    guard let episodeUrlString = character.episodes.first else {
                        continue
                    }
                    
                    group.enter()
                    self?.episodesService.getEpisode(urlString: episodeUrlString) { episodeResult in
                        switch episodeResult {
                        case .success(let episode):
                            episodeUrlToNameMappings[episodeUrlString] = episode.name
                        case .failure(let error):
                            print(error)
                        }
                        
                        group.leave()
                    }
                }
                
                group.notify(queue: DispatchQueue.global()) {
                    DispatchQueue.main.async { [weak self] in
                        self?.createViewModelsAndNavigateToMainCharacterList(
                            characters: characterResponse.results,
                            episodeUrlToNameMappings: episodeUrlToNameMappings,
                            completion: completion
                        )
                    }
                }
                
                break
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func createViewModelsAndNavigateToMainCharacterList(
            characters: [Character],
            episodeUrlToNameMappings: [String: String],
            completion: @escaping (Result<[CharacterViewModel], Error>) -> Void) {
                
        var characterViewModels: [CharacterViewModel] = []
        
        for character in characters {
            let episodeUrl = character.episodes.first ?? ""
            let episodeName = episodeUrlToNameMappings[episodeUrl] ?? ""
            let viewModel = CharacterViewModel(
                character: character,
                episodeName: episodeName
            )
            characterViewModels.append(viewModel)
        }
        
        print(characterViewModels)
        
        self.viewModels = characterViewModels
        completion(.success(characterViewModels))
        
//        let charactersService = CharactersService()
//        let viewModel = CharacterListViewModel(viewModels: characterViewModels)
//        let characterListVC = CharacterListViewController(viewModel: viewModel, delegate: self)
//        navigationController.pushViewController(characterListVC, animated: false)
    }
    
    func characterViewModel(at index: Int) -> CharacterViewModel? {
        guard index >= 0 && index < viewModels.count else {
            return nil
        }
        return viewModels[index]
    }
}
