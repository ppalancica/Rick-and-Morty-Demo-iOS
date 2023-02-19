//
//  UserProfileViewModel.swift
//  Rick-and-Morty-Demo-iOS
//
//  Created by Palancica Pavel on 19.02.2023.
//

import Foundation

protocol UserProfileViewModelType: AnyObject {
    
    var email: String { get }
    var characterViewModels: [FavoriteCharacterCellViewModel] { get }
    
    func getAllBookmarkedCharacters(completion: @escaping (Result<[FavoriteCharacterCellViewModel], Error>) -> Void)
}

class UserProfileViewModel: UserProfileViewModelType {
    
    let userProfile: UserProfile
    let bookmarkService: BookmarkServiceType
    let episodesService: EpisodesServiceType
    
    var email: String { return userProfile.email }
    var characterViewModels: [FavoriteCharacterCellViewModel] = []
    
    init(userProfile: UserProfile,
         bookmarkService: BookmarkServiceType,
         episodesService: EpisodesServiceType) {
        self.userProfile = userProfile
        self.bookmarkService = bookmarkService
        self.episodesService = episodesService
    }
    
    func getAllBookmarkedCharacters(completion: @escaping (Result<[FavoriteCharacterCellViewModel], Error>) -> Void) {
        bookmarkService.getAllBookmarkedCharacters { [weak self] result in
            switch result {
            case .success(let characters):
                
                let group = DispatchGroup()
                var episodeInfo: [String: Episode] = [:]
                
                for character in characters {

                    guard let episodeUrlString = character.episodes.first else {
                        continue
                    }

                    group.enter()
                    self?.episodesService.getEpisode(urlString: episodeUrlString) { episodeResult in
                        switch episodeResult {
                        case .success(let episode):
                            episodeInfo[episodeUrlString] = episode
                        case .failure(let error):
                            print(error)
                        }

                        group.leave()
                    }
                }

                group.notify(queue: DispatchQueue.global()) {
                    DispatchQueue.main.async { [weak self] in
                        guard let strongSelf = self else { return }
                        strongSelf.createFavoriteCharacterCellViewModels(
                            characters: characters,
                            episodeInfo: episodeInfo,
                            completion: completion
                        )
                    }
                }

            case .failure(let error):
                print(error)
            }
        }
    }
    
    func createFavoriteCharacterCellViewModels(
            characters: [Character],
            episodeInfo: [String: Episode],
            completion: @escaping (Result<[FavoriteCharacterCellViewModel], Error>
    ) -> Void) {
                
        var characterViewModels: [FavoriteCharacterCellViewModel] = []
        
        for character in characters {
            let episodeUrl = character.episodes.first ?? ""
            guard let episode = episodeInfo[episodeUrl] else {
                continue
            }
            let viewModel = FavoriteCharacterCellViewModel(
                character: character,
                episode: episode
            )
            characterViewModels.append(viewModel)
        }
        
        self.characterViewModels = characterViewModels
        completion(.success(characterViewModels))
    }
}
