//
//  SessionService.swift
//  Rick-and-Morty-Demo-iOS
//
//  Created by Palancica Pavel on 17.02.2023.
//

import Foundation
import FirebaseAuth

protocol SessionServiceType {
    
    var isUserLoggedIn: Bool { get }
    
    func createUser(withEmail email: String,
                    password: String,
                    completion: @escaping (Result<UserProfile, Error>) -> Void)
    
    func signIn(withEmail email: String,
                password: String,
                completion: @escaping (Result<UserProfile, Error>) -> Void)
}

class SessionService: SessionServiceType {
    
    var isUserLoggedIn: Bool {
        userProfile?.email != nil // We'll check token in a Production App
    }
    
    public private(set) var userProfile: UserProfile?
    
    func createUser(withEmail email: String,
                    password: String,
                    completion: @escaping (Result<UserProfile, Error>) -> Void) {
        
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let user = authResult?.user,
                  let email = user.email, !email.isEmpty else {
                print("Auth.auth().createUser(...) did not return a valid user")
                return
            }
            
            completion(.success(UserProfile(email: email)))
        }
    }
    
    
    func signIn(withEmail email: String,
                password: String,
                completion: @escaping (Result<UserProfile, Error>) -> Void) {
        
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let user = authResult?.user,
                  let email = user.email, !email.isEmpty else {
                print("Auth.auth().createUser(...) did not return a valid user")
                return
            }
            
            completion(.success(UserProfile(email: email)))
        }
    }
}
