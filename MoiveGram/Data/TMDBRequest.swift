//
//  TMDBRequest.swift
//  MoiveGram
//
//  Created by 김상규 on 6/26/24.
//

import Foundation
import Alamofire


enum TMDBAPIRequest {
    case trending
    case genre
    case cast(Int)
    case search(String, Int)
    case similar(Int)
    case recomandation(Int)
    case posters(Int)
    case videos(Int)
    
    var baseURL: String {
        return "https://api.themoviedb.org/3/"
    }
    
    var fullURL: URL {
        switch self {
        case .trending:
            return URL(string: baseURL + "trending/movie/week")!
        case .genre:
            return URL(string: baseURL + "genre/movie/list?language=en")!
        case .cast(let id):
            return URL(string: baseURL + "movie/\(id)/credits?language=kr-Ko")!
        case .search:
            return URL(string: baseURL + "search/movie")!
        case .similar(let id):
            return URL(string: baseURL + "movie/\(id)/similar")!
        case .recomandation(let id):
            return URL(string: baseURL + "movie/\(id)/recommendations")!
        case .posters(let id):
            return URL(string: baseURL + "movie/\(id)/images")!
        case .videos(let id):
            return URL(string: baseURL + "movie/\(id)/videos")!
        }
    }
    
    var headers: HTTPHeaders {
        return [ "Authorization": APIKey.tmdbKey ]
    }
    
    var parameter: Parameters {
        switch self {
        case .trending, .genre, .cast, .similar, .recomandation, .posters, .videos :
            return ["": ""]
        case .search(let query, let page):
            return [ "query": query, "page": "\(page)", "language": "kr-Ko"]
        }
    }
    
}
