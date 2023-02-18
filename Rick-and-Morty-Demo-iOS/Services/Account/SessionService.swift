//
//  SessionService.swift
//  Rick-and-Morty-Demo-iOS
//
//  Created by Palancica Pavel on 17.02.2023.
//

import Foundation
import FirebaseAuth

class SessionService: SessionServiceType {
    
    var isUserLoggedIn: Bool {
        userProfile?.email != nil // We'll check token in a Production App
    }
    
    public private(set) var userProfile: UserProfile?
    
    func createUser(withEmail email: String,
                    password: String,
                    completion: @escaping (Result<UserProfile, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            self.processAuthDataResponse(authResult: authResult, error: error, completion: completion)
        }
    }
    
    func signIn(withEmail email: String,
                password: String,
                completion: @escaping (Result<UserProfile, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            self.processAuthDataResponse(authResult: authResult, error: error, completion: completion)
        }
    }
}

// MARK: - Helper Methods

private extension SessionService {
    
    private func processAuthDataResponse(authResult: AuthDataResult?, error: Error?,
                                         completion: @escaping (Result<UserProfile, Error>) -> Void) {
        if let error = error {
            completion(.failure(error))
            return
        }
        
        guard let user = authResult?.user,
              let email = user.email, !email.isEmpty else {
            print("Auth.auth()'s createUser or signIn method did not return a valid user")
            return
        }
        
        completion(.success(UserProfile(email: email)))
    }
}
