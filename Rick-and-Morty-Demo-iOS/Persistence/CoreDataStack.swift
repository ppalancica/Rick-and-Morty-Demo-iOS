//
//  CoreDataStack.swift
//  Rick-and-Morty-Demo-iOS
//
//  Created by Palancica Pavel on 19.02.2023.
//

import CoreData

final class CoreDataStack {
    
    private lazy var mainContext: NSManagedObjectContext = persistentContainer.viewContext
    
    // MARK: - Core Data stack

    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Rick_and_Morty_Demo_iOS")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        guard mainContext.hasChanges else { return }
        
        do {
            try mainContext.save()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
    func saveUserWithEmail(email: String) {
        // If User with this email already saved - no need to create a new one
        if userEntityWith(email: email) == nil {
            let userEntity = UserEntity(context: mainContext)
            userEntity.email = email
        }
        
        let loggedInUserEntity: LoggedInUserEntity
        
        if let lastLoggedInUserEntity = lastLoggedInUserEntity() {
            loggedInUserEntity = lastLoggedInUserEntity
        } else {
            loggedInUserEntity = LoggedInUserEntity(context: mainContext)
        }
        
        loggedInUserEntity.email = email
        saveContext()
    }
    
    private func userEntityWith(email: String) -> UserEntity? {
        let request: NSFetchRequest<UserEntity> = UserEntity.fetchRequest()
        request.predicate = NSPredicate(format: "email = %@", email)
        
        var fetchedUsers: [UserEntity] = []
        
        do {
            fetchedUsers = try mainContext.fetch(request)
        } catch let error {
            print("Error fetching users \(error)")
        }
      
        return fetchedUsers.first
    }
    
    func lastLoggedInUserEntity() -> LoggedInUserEntity? {
        let request: NSFetchRequest<LoggedInUserEntity> = LoggedInUserEntity.fetchRequest()
        var fetchedUsers: [LoggedInUserEntity] = []

        do {
            fetchedUsers = try mainContext.fetch(request)
        } catch let error {
            print("Error fetching users \(error)")
        }
      
        return fetchedUsers.first
    }
    
    func removeLoggedInUserEntity() {
        guard let loggedInUserEntity = lastLoggedInUserEntity() else {
            // Entity not found
            return
        }
        mainContext.delete(loggedInUserEntity)
        saveContext()
    }
    
    func bookmarkedCharacterIdsForLoggedInUser(with email: String) -> [Int] {
        guard let entity = userEntityWith(email: email) else {
            return []
        }
        
        if let characterEntities = entity.characters?.allObjects as? [CharacterEntity] {
            return characterEntities.map { Int($0.id) }
        }
        
        return []
    }
    
    private func characterEntityWith(characterId: Int, userEmail: String) -> CharacterEntity? {
        let request: NSFetchRequest<CharacterEntity> = CharacterEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id = %@", String(characterId))
        
        var fetchedCharacters: [CharacterEntity] = []
        
        do {
            fetchedCharacters = try mainContext.fetch(request)
        } catch let error {
            print("Error fetching characters \(error)")
        }
      
        return fetchedCharacters.first
    }
    
    func bookmarkToggleCharacterForLoggedInUser(characterId: Int, email: String, completion: (Result<Bool, Error>) -> Void) {
        guard let userEntity = userEntityWith(email: email) else {
            // ...
            return
        }
        
        let characterEntities = (userEntity.characters?.allObjects as? [CharacterEntity]) ?? []
        
        if characterEntities.contains(where: { $0.id == characterId } ) {
            // Remove from Bookmarks
            guard let characterEntityToUnbookmark = characterEntities.first(where: { $0.id == characterId }) else {
                return
            }
            userEntity.removeFromCharacters(characterEntityToUnbookmark)
            characterEntityToUnbookmark.bookmarkingUser = nil
        } else {
            // Add to Bookmarks
            let characterEntityToBookMark = CharacterEntity(context: mainContext)
            characterEntityToBookMark.id = Int16(characterId)
            userEntity.addToCharacters(characterEntityToBookMark)
            characterEntityToBookMark.bookmarkingUser = userEntity
        }

        do {
            try mainContext.save()
            completion(.success(true))
        } catch {
            completion(.failure(error))
        }
    }
    
    func getAllBookmarkedCharactersIdsForLoggedInUser(email: String, completion: @escaping (Result<[Int], Error>) -> Void) {
        guard let userEntity = userEntityWith(email: email) else {
            // ...
            return
        }
        
        let characterEntities = (userEntity.characters?.allObjects as? [CharacterEntity]) ?? []
        let charactersIds = characterEntities.map { Int($0.id) }
        
        completion(.success(charactersIds))
    }
}
