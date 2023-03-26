//
//  Movie.swift
//  MovieChallenge
//
//  Created by Tatiana Carvajal on 8/03/23.
//

import Foundation

struct Movie: Decodable {
    let title: String
    let adult: Bool
    let originalLanguage: String
    let popularity: Double
    let poster: String
    let id: Int
    let overview: String
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case adult = "adult"
        case originalLanguage = "original_language"
        case popularity = "popularity"
        case poster = "poster_path"
        case id = "id"
        case overview = "overview"
    }
    
    init(title: String, adult: Bool, originalLanguage: String, popularity: Double, poster: String, id: Int, overview: String) {
        self.title = title
        self.adult = adult
        self.originalLanguage = originalLanguage
        self.popularity = popularity
        self.poster = poster
        self.id = id
        self.overview = overview
    }
    
    
}
