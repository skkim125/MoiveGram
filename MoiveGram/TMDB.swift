//
//  TMDB.swift
//  MoiveGram
//
//  Created by 김상규 on 6/10/24.
//

import Foundation

struct Trending: Decodable {
    let results: [Content]
}

struct Content: Decodable {
    let id: Int
    let title: String
    let rate: Double
    let releaseDate: String
    let genreIds: [Int]
    let background: String?
    let poster: String?
    let overview: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "original_title"
        case rate = "vote_average"
        case releaseDate = "release_date"
        case genreIds = "genre_ids"
        case background = "backdrop_path"
        case poster = "poster_path"
        case overview = "overview"
    }
}

struct GenreList: Decodable {
    let genres: [Genre]
}

struct Genre: Decodable {
    let id: Int
    let name: String
}

struct Credit: Decodable {
    let id: Int
    let cast: [Cast]
    let crew: [Crew]
}

struct Cast: Decodable {
    let name: String
    let character: String?
    let profile: String?
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case character = "character"
        case profile = "profile_path"
    }
}

struct Crew: Decodable {
    let name: String
    let department: String?
    let profile: String?
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case department = "department"
        case profile = "profile_path"
    }
}

struct SearchMovie: Decodable {
    let page: Int
    let results: [Content]
    let totalPages: Int
    let totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case page = "page"
        case results = "results"
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

struct SimilarMovies: Decodable {
    let results: [SimilarMovie]
    let totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case results = "results"
        case totalResults = "total_results"
    }
}

struct SimilarMovie: Decodable {
    let poster: String?
    
    enum CodingKeys: String, CodingKey {
        case poster = "poster_path"
    }
}

struct Recommendations: Decodable {
    let results: [Recommendation]
    let totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case results = "results"
        case totalResults = "total_results"
    }
}

struct Recommendation: Decodable {
    let poster: String?
    
    enum CodingKeys: String, CodingKey {
        case poster = "poster_path"
    }
}

struct Posters: Decodable {
    let posters: [Poster]
}

struct Poster: Decodable {
    let file: String?
    
    enum CodingKeys: String, CodingKey {
        case file = "file_path"
    }
}
