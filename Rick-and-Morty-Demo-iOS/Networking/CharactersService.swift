//
//  CharactersService.swift
//  Rick-and-Morty-Demo-iOS
//
//  Created by Palancica Pavel on 15.02.2023.
//

import Foundation

protocol CharactersServiceType {
    
    func getAllCharacters(completion: @escaping (Result<CharacterResponse, Error>) -> Void)
}

class CharactersService: CharactersServiceType {
    
    func getAllCharacters(completion: @escaping (Result<CharacterResponse, Error>) -> Void) {
        guard let url = URL(string: "https://rickandmortyapi.com/api/character") else {
            completion(.failure(APIError.invalidURL)); return
        }
        
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard error == nil else {
                completion(.failure(APIError.clientError)); return
            }
            
            guard let response = response as? HTTPURLResponse,
                  response.statusCode >= 200, response.statusCode <= 300 else {
                completion(.failure(APIError.serverError)); return
            }
            
            guard let data = data else {
                completion(.failure(APIError.dataError)); return
            }
            
            DispatchQueue.main.async {
                do {
                    let characterResponse = try JSONDecoder().decode(CharacterResponse.self, from: data)
                    completion(.success(characterResponse))
                } catch {
                    completion(.failure(APIError.jsonDecodingError))
                }
            }
        }
        
        task.resume()
    }
}
