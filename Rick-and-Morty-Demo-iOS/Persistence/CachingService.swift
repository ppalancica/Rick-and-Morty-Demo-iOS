//
//  CachingService.swift
//  Rick-and-Morty-Demo-iOS
//
//  Created by Palancica Pavel on 19.02.2023.
//

import Foundation

protocol CachingServiceType: AnyObject {
    
    static var shared: CachingService { get }
    
    func saveUserProfile(_ userProfile: UserProfile)
    func lastLoggedInUserEmail() -> String
    func removeLoggedInUser()
    
    func isCharacterBookmarkedForLoggedInUser(characterId: Int, email: String) -> Bool
    func bookmarkToggleForCharacter(characterId: Int, email: String, completion: (Result<Bool, Error>) -> Void)
    func getAllBookmarkedCharactersIds(email: String, completion: @escaping (Result<[Int], Error>) -> Void)
}

class CachingService: CachingServiceType {
    
    static var shared = CachingService()
    
    private var coreDataStack = CoreDataStack()
    
    func saveUserProfile(_ userProfile: UserProfile) {
        coreDataStack.saveUserWithEmail(email: userProfile.email)
    }
        
    func lastLoggedInUserEmail() -> String {
        return coreDataStack.lastLoggedInUserEntity()?.email ?? ""
    }
    
    func removeLoggedInUser() {
        coreDataStack.removeLoggedInUserEntity()
    }
    
    func isCharacterBookmarkedForLoggedInUser(characterId: Int, email: String) -> Bool {
        let characterIds = coreDataStack.bookmarkedCharacterIdsForLoggedInUser(with: email)
        return characterIds.contains(characterId)
    }
    
    func bookmarkToggleForCharacter(characterId: Int, email: String, completion: (Result<Bool, Error>) -> Void) {
        coreDataStack.bookmarkToggleCharacterForLoggedInUser(characterId: characterId, email: email, completion: completion)
    }
    
    func getAllBookmarkedCharactersIds(email: String, completion: @escaping (Result<[Int], Error>) -> Void) {
        coreDataStack.getAllBookmarkedCharactersIdsForLoggedInUser(email: email, completion: completion)
    }
}
