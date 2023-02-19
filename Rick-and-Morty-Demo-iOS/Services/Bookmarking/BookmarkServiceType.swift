//
//  BookmarkServiceType.swift
//  Rick-and-Morty-Demo-iOS
//
//  Created by Palancica Pavel on 19.02.2023.
//

import Foundation

protocol BookmarkServiceType {
    
    init(sessionService: SessionServiceType, charactersService: CharactersService)
    
    var isBookmarkEnabled: Bool { get }
    
    func isCharacterBookmarked(with characterId: Int) -> Bool
    func bookmarkToggleForCharacter(with characterId: Int, completion: (Result<Bool, Error>) -> Void)
    
    func getAllBookmarkedCharacters(completion: @escaping (Result<[Character], Error>) -> Void)
}
