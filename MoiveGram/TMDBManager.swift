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
    
    func callTrendingRequest(completionHandler: @escaping ([Content]) -> ()) {
        let url = "https://api.themoviedb.org/3/trending/movie/week"
        let header: HTTPHeaders = [
            "Authorization": APIKey.tmdbKey,
            "accept": "application/json"
        ]
        
        AF.request(url, method: .get, headers: header).responseDecodable(of: Trending.self) { response in
            switch response.result {
            case .success(let value):
                
                completionHandler(value.results)
                
            case.failure(let error):
                print("\(error)")
            }
        }
    }
    
    func callSearchResultRequest(keyword: String, currentPage: Int, completionHandler: @escaping (SearchMovie) -> ()) {
        let url = "https://api.themoviedb.org/3/search/movie"
        let header: HTTPHeaders = [
            "Authorization": APIKey.tmdbKey,
        ]
        let paramters: Parameters = [
            "query": keyword,
            "page": currentPage,
            "language": "kr-Ko"
        ]
        
        AF.request(url, method: .get, parameters: paramters, headers: header).responseDecodable(of: SearchMovie.self) { response in
            switch response.result {
            case .success(let value):
                completionHandler(value)
                
            case.failure(let error):
                print("\(error)")
            }
        }
    }
    
    func requestSimilarMovies(movieID: Int, completionHandler: @escaping ([SimilarMovie]) -> ()) {
        let url = "https://api.themoviedb.org/3/movie/\(movieID)/similar"
        
        let header: HTTPHeaders = [
            "Authorization": APIKey.tmdbKey,
            "accept": "application/json"
        ]
        
        AF.request(url, headers: header).responseDecodable(of: SimilarMovies.self) { response in
            switch response.result {
            case .success(let success):
                completionHandler(success.results)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func requestRecomendations(movieID: Int, completionHandler: @escaping ([Recommendation]) -> ()) {
        let url = "https://api.themoviedb.org/3/movie/\(movieID)/recommendations"
        
        let header: HTTPHeaders = [
            "Authorization": APIKey.tmdbKey,
            "accept": "application/json"
        ]
        
        AF.request(url, headers: header).responseDecodable(of: Recommendations.self) { response in
            switch response.result {
            case .success(let success):
                completionHandler(success.results)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func requestPosters(movieID: Int, completionHandler: @escaping ([Poster]) -> ()) {
        let url = "https://api.themoviedb.org/3/movie/\(movieID)/images"
        
        let header: HTTPHeaders = [
            "Authorization": APIKey.tmdbKey,
            "accept": "application/json"
        ]
        
        AF.request(url, headers: header).responseDecodable(of: Posters.self) { response in
            switch response.result {
            case .success(let success):
                completionHandler(success.posters)
            case .failure(let error):
                print(error)
            }
        }
    }
}
