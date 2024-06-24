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
    let original_title: String
    let vote_average: Double
    let release_date: String
    let genre_ids: [Int]
    let backdrop_path: String?
    let poster_path: String?
    let overview: String
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
    let profile_path: String?
}

struct Crew: Decodable {
    let name: String
    let department: String?
    let profile_path: String?
}

struct SearchMovie: Decodable {
    let page: Int
    let results: [Content]
    let total_pages: Int
    let total_results: Int
}

struct SimilarMovies: Decodable {
    var results: [SimilarMovie]
    var total_results: Int
}

struct SimilarMovie: Decodable {
    var poster_path: String?
}

struct Recommendations: Decodable {
    var results: [Recommendation]
    var total_results: Int
}

struct Recommendation: Decodable {
    var poster_path: String?
}

struct Posters: Decodable {
    var posters: [Poster]
}

struct Poster: Decodable {
    var file_path: String?
}
