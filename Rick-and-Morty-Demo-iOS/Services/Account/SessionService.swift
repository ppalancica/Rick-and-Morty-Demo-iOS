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
        guard let email = userProfile?.email else { return false }
        return !email.isEmpty // We'll check token in a Production App
    }
    
    var loggedInUserEmail: String = ""
    public private(set) var userProfile: UserProfile?
    
    init() {
        self.loggedInUserEmail = UserDefaults.standard.string(forKey: "loggedInUserEmail") ?? ""
    }
    
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
//        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
//            self.processAuthDataResponse(authResult: authResult, error: error, completion: completion)
//        }
        let userProfile = UserProfile(email: "pavel001@gmail.com") // UserProfile(email: email)
        self.userProfile = userProfile
        UserDefaults.standard.setValue(userProfile.email, forKey: "loggedInUserEmail")
        completion(.success(userProfile))
    }
    
    func logout(completion: @escaping (Result<Bool, Error>) -> Void) {
        UserDefaults.standard.removeObject(forKey: "loggedInUserEmail")
        userProfile = nil
        loggedInUserEmail = ""
        completion(.success(true))
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
        
        let userProfile = UserProfile(email: email)
        self.userProfile = userProfile
        loggedInUserEmail = userProfile.email
        UserDefaults.standard.setValue(userProfile.email, forKey: "loggedInUserEmail")
        completion(.success(userProfile))
    }
}
