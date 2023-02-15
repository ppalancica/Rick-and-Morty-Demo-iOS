//
//  APIError.swift
//  Rick-and-Morty-Demo-iOS
//
//  Created by Palancica Pavel on 15.02.2023.
//

import Foundation

enum APIError: Error {
    case invalidURL
    case clientError
    case serverError
    case dataError
    case jsonDecodingError
}
