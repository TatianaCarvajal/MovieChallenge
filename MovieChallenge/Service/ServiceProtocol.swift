//
//  ServiceProtocol.swift
//  MovieChallenge
//
//  Created by Tatiana Carvajal on 8/03/23.
//

import Foundation

protocol ServiceProtocol {
    func fetchTopRatedMovies(completionHandler: @escaping (Result<MovieListResponse, Error>) -> Void)
    func fetchGenreListMovies(completionHandler: @escaping (Result<GenreListResponse, Error>) -> Void)
    func fetchMoviesOfGenre(id: Int, completionHandler: @escaping (Result<MovieListResponse, Error>) -> Void)
    func fetchMoviesDetail(id: Int, completionHandler: @escaping (Result<Movie, Error>) -> Void)
}

