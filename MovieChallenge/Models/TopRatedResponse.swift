//
//  TopRatedResponse.swift
//  MovieChallenge
//
//  Created by Tatiana Carvajal on 8/03/23.
//

import Foundation

struct TopRatedResponse: Decodable {
    let results: [Movie]
}
