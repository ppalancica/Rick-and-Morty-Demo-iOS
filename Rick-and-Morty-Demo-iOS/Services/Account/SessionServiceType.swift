//
//  SessionServiceType.swift
//  Rick-and-Morty-Demo-iOS
//
//  Created by Palancica Pavel on 18.02.2023.
//

import Foundation

protocol SessionServiceType {
    
    var isUserLoggedIn: Bool { get }
    
    func createUser(withEmail email: String,
                    password: String,
                    completion: @escaping (Result<UserProfile, Error>) -> Void)
    
    func signIn(withEmail email: String,
                password: String,
                completion: @escaping (Result<UserProfile, Error>) -> Void)
}
