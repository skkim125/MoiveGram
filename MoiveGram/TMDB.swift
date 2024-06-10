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
    let title: String?
    let vote_average: Double
    let release_date: String
    let genre_ids: [Int]
    let backdrop_path: String
    let poster_path: String
}

