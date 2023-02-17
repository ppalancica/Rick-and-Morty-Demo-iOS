//
//  CharactersService.swift
//  Rick-and-Morty-Demo-iOS
//
//  Created by Palancica Pavel on 15.02.2023.
//

import Foundation

protocol CharactersServiceType: AnyObject {
    
    func getAllCharacters(completion: @escaping (Result<CharacterPage, Error>) -> Void)
    func getCharacter(urlString: String, completion: @escaping (Result<Character, Error>) -> Void)
}

class CharactersService: CharactersServiceType {
    
    func getAllCharacters(completion: @escaping (Result<CharacterPage, Error>) -> Void) {
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
                    let characterResponse = try JSONDecoder().decode(CharacterPage.self, from: data)
                    completion(.success(characterResponse))
                } catch {
                    completion(.failure(APIError.jsonDecodingError))
                }
            }
        }
        
        task.resume()
    }
    
    func getCharacter(urlString: String, completion: @escaping (Result<Character, Error>) -> Void) {
        guard let url = URL(string: urlString) else {
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
                    let character = try JSONDecoder().decode(Character.self, from: data)
                    completion(.success(character))
                } catch {
                    completion(.failure(APIError.jsonDecodingError))
                }
            }
        }
        
        task.resume()
    }
}
