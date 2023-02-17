//
//  BookmarkService.swift
//  Rick-and-Morty-Demo-iOS
//
//  Created by Palancica Pavel on 17.02.2023.
//

import Foundation

protocol BookmarkServiceType {
    
    func isCharacterBookmarked(with characterId: Int) -> Bool
    func bookmarkCharacter(with characterId: Int)
}

class BookmarkService: BookmarkServiceType {
    
    func isCharacterBookmarked(with characterId: Int) -> Bool {
        let bookmarkIds: [Int] = UserDefaults.standard.value(forKey: "BookmarkIds") as? [Int] ?? []
        return bookmarkIds.contains(characterId)
    }
    
    func bookmarkCharacter(with characterId: Int) {
        let bookmarkIds: [Int] = UserDefaults.standard.array(forKey: "BookmarkIds") as? [Int] ?? []
        var updatedBookmarkIds = bookmarkIds
        updatedBookmarkIds.append(characterId)
        UserDefaults.standard.setValue(updatedBookmarkIds, forKey: "BookmarkIds")
    }
}
