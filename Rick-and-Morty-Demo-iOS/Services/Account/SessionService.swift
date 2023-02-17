//
//  SessionService.swift
//  Rick-and-Morty-Demo-iOS
//
//  Created by Palancica Pavel on 17.02.2023.
//

import Foundation

protocol SessionServiceType {
    
    var isUserLoggedIn: Bool { get }
}

class SessionService: SessionServiceType {
    
    var isUserLoggedIn: Bool {
        return false
    }
}
