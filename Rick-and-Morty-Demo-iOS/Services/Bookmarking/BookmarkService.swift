//
//  BookmarkService.swift
//  Rick-and-Morty-Demo-iOS
//
//  Created by Palancica Pavel on 17.02.2023.
//

import Foundation

class BookmarkService: BookmarkServiceType {
    
    private let sessionService: SessionServiceType
    private let charactersService: CharactersService
    private let cachingService = CachingService.shared
    
    required init(sessionService: SessionServiceType, charactersService: CharactersService) {
        self.sessionService = sessionService
        self.charactersService = charactersService
    }
    
    var isBookmarkEnabled: Bool {
        return sessionService.isUserLoggedIn
    }
    
    func isCharacterBookmarked(with characterId: Int) -> Bool {
        let email = sessionService.loggedInUserEmail
        guard isBookmarkEnabled, !email.isEmpty else {
            return false
        }
        
        return cachingService.isCharacterBookmarkedForLoggedInUser(characterId: characterId, email: email)
    }
    
    func bookmarkToggleForCharacter(with characterId: Int, completion: (Result<Bool, Error>) -> Void) {
        let email = sessionService.loggedInUserEmail
        guard isBookmarkEnabled, !email.isEmpty else {
            completion(.failure(BookmarkError.featureDisabledForAnonymousUsers))
            return
        }
        
        cachingService.bookmarkToggleForCharacter(characterId: characterId, email: email, completion: completion)
    }
    
    func getAllBookmarkedCharacters(completion: @escaping (Result<[Character], Error>) -> Void) {
        let email = sessionService.loggedInUserEmail
        guard isBookmarkEnabled, !email.isEmpty else {
            completion(.failure(BookmarkError.featureDisabledForAnonymousUsers))
            return
        }
        
        cachingService.getAllBookmarkedCharactersIds(email: email) { [weak self] result in
            switch result {
            case .success(let characterIds):
                guard let strongSelf = self else { return }
                strongSelf.charactersService.getCharacterWithIds(ids: characterIds, completion: completion)
                break
            case .failure(let error):
                print(error)
                break
            }
        }
    }
}
