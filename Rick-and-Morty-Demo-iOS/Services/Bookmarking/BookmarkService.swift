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
    
    required init(sessionService: SessionServiceType, charactersService: CharactersService) {
        self.sessionService = sessionService
        self.charactersService = charactersService
    }
    
    var isBookmarkEnabled: Bool {
        return sessionService.isUserLoggedIn
    }
    
    func isCharacterBookmarked(with characterId: Int) -> Bool {
        let email = sessionService.loggedInUserEmail
        guard isBookmarkEnabled, !email.isEmpty else { return false }
        let key = "\(email)_BookmarkIds"
        let bookmarkIds: [Int] = UserDefaults.standard.value(forKey: key) as? [Int] ?? []
        return bookmarkIds.contains(characterId)
    }
    
    func bookmarkToggleForCharacter(with characterId: Int, completion: (Result<Bool, Error>) -> Void) {
        let email = sessionService.loggedInUserEmail
        guard isBookmarkEnabled, !email.isEmpty else {
            completion(.failure(BookmarkError.featureDisabledForAnonymousUsers))
            return
        }
        let key = "\(email)_BookmarkIds"
        let bookmarkIds: [Int] = UserDefaults.standard.array(forKey: key) as? [Int] ?? []
        var updatedBookmarkIds = bookmarkIds
        
        if bookmarkIds.contains(characterId) {
            // Remove from Bookmarks
            updatedBookmarkIds.removeFirst(characterId)
        } else {
            // Add to Bookmarks
            updatedBookmarkIds.append(characterId)
        }
        UserDefaults.standard.setValue(updatedBookmarkIds, forKey: key)
        completion(.success(true))
    }
    
    func getAllBookmarkedCharacters(completion: @escaping (Result<[Character], Error>) -> Void) {
        let email = sessionService.loggedInUserEmail
        guard isBookmarkEnabled, !email.isEmpty else {
            completion(.failure(BookmarkError.featureDisabledForAnonymousUsers))
            return
        }
        let key = "\(email)_BookmarkIds"
        let bookmarkIds: [Int] = UserDefaults.standard.array(forKey: key) as? [Int] ?? []
        
        charactersService.getCharacterWithIds(ids: bookmarkIds, completion: completion)
    }
}
