//
//  Movie.swift
//  MovieChallenge
//
//  Created by Tatiana Carvajal on 8/03/23.
//

import Foundation

class Movie: Decodable {
    let title: String
    let adult: Bool
    let originalLanguage: String
    let popularity: Double
    
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case adult = "adult"
        case originalLanguage = "original_language"
        case popularity = "popularity"
    }
    
    init(title: String, adult: Bool, originalLanguage: String, popularity: Double) {
        self.title = title
        self.adult = adult
        self.originalLanguage = originalLanguage
        self.popularity = popularity
    }
    
    
}
