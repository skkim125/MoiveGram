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
    
    func callTrendingRequest(api: TMDBAPIRequest, completionHandler: @escaping ([Content]) -> ()) {
        AF.request(api.endPoint, parameters: api.parameter, headers: api.headers).responseDecodable(of: Trending.self) { response in
            switch response.result {
            case .success(let value):
                
                completionHandler(value.results)
                
            case.failure(let error):
                print("\(error)")
            }
        }
    }
    
    func callGenreRequest(api: TMDBAPIRequest, completionHandler: @escaping ([Genre]) -> ()) {
        
        AF.request(api.endPoint, parameters: api.parameter, headers: api.headers).responseDecodable(of: GenreList.self) { response in
            switch response.result {
            case .success(let value):
                
                completionHandler(value.genres)
            case.failure(let error):
                print("\(error)")
            }
        }
    }
    
    func callCastRequest(api: TMDBAPIRequest, completionHandler: @escaping (Credit) -> ()) {
        
        AF.request(api.endPoint, parameters: api.parameter, headers: api.headers).responseDecodable(of: Credit.self) { response in
            switch response.result {
            case .success(let value):
                
                completionHandler(value)
                
            case.failure(let error):
                print("\(error)")
            }
        }
    }
    
    func callSearchResultRequest(api: TMDBAPIRequest, completionHandler: @escaping (SearchMovie) -> ()) {
        
        AF.request(api.endPoint, parameters: api.parameter, headers: api.headers).responseDecodable(of: SearchMovie.self) { response in
            switch response.result {
            case .success(let value):
                completionHandler(value)
                
            case.failure(let error):
                print("\(error)")
            }
        }
    }
    
    func requestSimilarMovies(api: TMDBAPIRequest, completionHandler: @escaping ([SimilarMovie]) -> ()) {
        
        AF.request(api.endPoint, parameters: api.parameter, headers: api.headers).responseDecodable(of: SimilarMovies.self) { response in
            switch response.result {
            case .success(let success):
                completionHandler(success.results)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func requestRecomendations(api: TMDBAPIRequest, completionHandler: @escaping ([Recommendation]) -> ()) {

        AF.request(api.endPoint, parameters: api.parameter, headers: api.headers).responseDecodable(of: Recommendations.self) { response in
            switch response.result {
            case .success(let success):
                completionHandler(success.results)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func requestPosters(api: TMDBAPIRequest, completionHandler: @escaping ([Poster]) -> ()) {
        
        AF.request(api.endPoint, parameters: api.parameter, headers: api.headers).responseDecodable(of: Posters.self) { response in
            switch response.result {
            case .success(let success):
                completionHandler(success.posters)
                print(#function, success)
            case .failure(let error):
                print(error)
            }
        }
    }
}
