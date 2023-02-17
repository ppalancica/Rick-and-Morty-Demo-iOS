//
//  EpisodesService.swift
//  Rick-and-Morty-Demo-iOS
//
//  Created by Palancica Pavel on 16.02.2023.
//

import Foundation

protocol EpisodesServiceType: AnyObject {
    
    func getEpisode(id: Int, completion: @escaping (Result<Episode, Error>) -> Void)
    func getEpisode(urlString: String, completion: @escaping (Result<Episode, Error>) -> Void)
    
//    func getEpisodeCharacters(id: Int, completion: @escaping (Result<[Character], Error>) -> Void)
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
    
//    func getEpisodeCharacters(id: Int, completion: @escaping (Result<[Character], Error>) -> Void) {
//        getEpisode(id: id) { episodeResult in
//
//            let group = DispatchGroup()
//
//            switch episodeResult {
//            case .success(let episode):
//
//                for urlString in episode.charactersUrls {
//
//                    group.enter()
//
//                    self?.ch
//
////                    self?.episodesService.getEpisode(urlString: episodeUrlString) { episodeResult in
////                        switch episodeResult {
////                        case .success(let episode):
////                            episodeInfo[episodeUrlString] = episode
////                        case .failure(let error):
////                            print(error)
////                        }
////
////                        group.leave()
////                    }
//                }
//
//
//
//
//
//                break
//            case .failure(let error):
//                break
//            }
//
//
////            for urlString in episode.charactersUrls {
////
////                guard let episodeUrlString = character.episodes.first else {
////                    continue
////                }
////
////                group.enter()
////                self?.episodesService.getEpisode(urlString: episodeUrlString) { episodeResult in
////                    switch episodeResult {
////                    case .success(let episode):
////                        episodeInfo[episodeUrlString] = episode
////                    case .failure(let error):
////                        print(error)
////                    }
////
////                    group.leave()
////                }
////            }
//
//
//
//
////            charactersService.getAllCharacters { [weak self] result in
////                switch result {
////                case .success(let characterResponse):
////                    var episodeInfo: [String: Episode] = [:]
////
////
////
////                    group.notify(queue: DispatchQueue.global()) {
////                        DispatchQueue.main.async { [weak self] in
////                            self?.createCharacterViewModels(
////                                characters: characterResponse.results,
////                                episodeInfo: episodeInfo,
////                                completion: completion
////                            )
////                        }
////                    }
////
////                    break
////                case .failure(let error):
////                    print(error)
////                }
////            }
//
//
//
//
//
//        }
//
//
//
//
////        guard let url = URL(string: "https://rickandmortyapi.com/api/episode/\(id)") else {
////            completion(.failure(APIError.invalidURL)); return
////        }
////
////        let request = URLRequest(url: url)
////        let task = URLSession.shared.dataTask(with: request) { data, response, error in
////
////            guard error == nil else {
////                completion(.failure(APIError.clientError)); return
////            }
////
////            guard let response = response as? HTTPURLResponse,
////                  response.statusCode >= 200, response.statusCode <= 300 else {
////                completion(.failure(APIError.serverError)); return
////            }
////
////            guard let data = data else {
////                completion(.failure(APIError.dataError)); return
////            }
////
////            DispatchQueue.main.async {
////                do {
////                    let episode = try JSONDecoder().decode(Episode.self, from: data)
////                    completion(.success(episode))
////                } catch {
////                    completion(.failure(APIError.jsonDecodingError))
////                }
////            }
////        }
////
////        task.resume()
//    }
}
