//
//  ServiceProtocol.swift
//  MovieChallenge
//
//  Created by Tatiana Carvajal on 8/03/23.
//

import Foundation

protocol ServiceProtocol {
    func fetchTopRatedMovies(completionHandler: @escaping (Result<TopRatedResponse, Error>) -> Void)
}
