//
//  TMDBManager.swift
//  MoiveGram
//
//  Created by 김상규 on 6/24/24.
//

import Foundation
import Alamofire

class TMDBManager {
    static let shared = TMDBManager()
    
    private init() { }
    
    func requestSimilarMovies(movieID: Int, completionHandler: @escaping (SimilarMovies) -> ()) {
        let url = "https://api.themoviedb.org/3/movie/\(movieID)/similar"
        
        let header: HTTPHeaders = [
            "Authorization": APIKey.tmdbKey,
            "accept": "application/json"
        ]
        
        AF.request(url, headers: header).responseDecodable(of: SimilarMovies.self) { response in
            switch response.result {
            case .success(let success):
                completionHandler(success)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func requestRecomendations(movieID: Int, completionHandler: @escaping (Recommendations) -> ()) {
        let url = "https://api.themoviedb.org/3/movie/\(movieID)/recommendations"
        
        let header: HTTPHeaders = [
            "Authorization": APIKey.tmdbKey,
            "accept": "application/json"
        ]
        
        AF.request(url, headers: header).responseDecodable(of: Recommendations.self) { response in
            switch response.result {
            case .success(let success):
                completionHandler(success)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func requestPosters(movieID: Int, completionHandler: @escaping (Posters) -> ()) {
        let url = "https://api.themoviedb.org/3/movie/\(movieID)/images"
        
        let header: HTTPHeaders = [
            "Authorization": APIKey.tmdbKey,
            "accept": "application/json"
        ]
        
        AF.request(url, headers: header).responseDecodable(of: Posters.self) { response in
            switch response.result {
            case .success(let success):
                completionHandler(success)
            case .failure(let error):
                print(error)
            }
        }
    }
}
