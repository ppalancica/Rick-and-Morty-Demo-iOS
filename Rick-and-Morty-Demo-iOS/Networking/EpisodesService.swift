//
//  EpisodesService.swift
//  Rick-and-Morty-Demo-iOS
//
//  Created by Palancica Pavel on 16.02.2023.
//

import Foundation

protocol EpisodesServiceType {
    
    func getEpisode(id: Int, completion: @escaping (Result<Episode, Error>) -> Void)
    func getEpisode(urlString: String, completion: @escaping (Result<Episode, Error>) -> Void)
}

class EpisodesService: EpisodesServiceType {
    
    func getEpisode(id: Int, completion: @escaping (Result<Episode, Error>) -> Void) {
        guard let url = URL(string: "https://rickandmortyapi.com/api/episode/\(id)") else {
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
                    let episode = try JSONDecoder().decode(Episode.self, from: data)
                    completion(.success(episode))
                } catch {
                    completion(.failure(APIError.jsonDecodingError))
                }
            }
        }
        
        task.resume()
    }
    
    func getEpisode(urlString: String, completion: @escaping (Result<Episode, Error>) -> Void) {
        guard let url = URL(string: urlString),
              let episodeId = Int(url.lastPathComponent) else {
            completion(.failure(APIError.invalidURL)); return
        }
        getEpisode(id: episodeId, completion: completion)
    }
}
