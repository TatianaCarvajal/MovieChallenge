//
//  ServiceProtocolMock.swift
//  MovieChallengeTests
//
//  Created by Tatiana Carvajal on 9/05/23.
//

import Foundation
@testable import MovieChallenge

class ServiceProtocolMock: ServiceProtocol {
    
    
    func fetchTopRatedMovies(completionHandler: @escaping (Result<MovieChallenge.MovieListResponse, Error>) -> Void) {
        let result = MovieListResponse(results: [
            .init(title: "Mock movie", adult: false, originalLanguage: "mock language", popularity: 0, poster: "Mock poster", id: 100, overview: "Mock overview")
        ])
        completionHandler(.success(result))
    }
    
    func fetchGenreListMovies(completionHandler: @escaping (Result<MovieChallenge.GenreListResponse, Error>) -> Void) {
        let result = GenreListResponse(genres: [
            .init(id: 0, name: "Mock genre")
        ])
        completionHandler(.success(result))
    }
    
    func fetchMoviesOfGenre(id: Int, completionHandler: @escaping (Result<MovieChallenge.MovieListResponse, Error>) -> Void) {
        let result = MovieListResponse(results: [
            .init(title: "Mock movie genre", adult: false, originalLanguage: "mock language", popularity: 0, poster: "mock poster", id: 0, overview: "mock overview")
        ])
        completionHandler(.success(result))
    }
    
    func fetchMoviesDetail(id: Int, completionHandler: @escaping (Result<MovieChallenge.Movie, Error>) -> Void) {
        let result = Movie(title: "Mock Movie", adult: false, originalLanguage: "Es", popularity: 10.0, poster: "poster", id: 999, overview: "Overview mock")
        completionHandler(.success(result))
    }
}
