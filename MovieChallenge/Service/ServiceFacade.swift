//
//  ServiceFacade.swift
//  MovieChallenge
//
//  Created by Tatiana Carvajal on 8/03/23.
//

import Foundation

struct ServiceFacade: ServiceProtocol {
       
    private let baseUrl = "https://api.themoviedb.org/3"
    private let key = "bf838c187a8538baab023fc879b8200c"
   
    func fetchTopRatedMovies(completionHandler: @escaping (Result<MovieListResponse, Error>) -> Void) {
        guard let url = URL(string: "\(baseUrl)/movie/top_rated?api_key=\(key)") else {
            completionHandler(.failure(ServiceError.urlDoesNotExist))
            return
        }
        
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data else {
                completionHandler(.failure(ServiceError.noDataFound))
                return
            }
            
            do {
                let response = try JSONDecoder().decode(MovieListResponse.self, from: data)
                completionHandler(.success(response))
            }
            catch {
                print(error)
                completionHandler(.failure(ServiceError.serializationFailed))
            }
        }.resume()
    }
    
    func fetchGenreListMovies(completionHandler: @escaping (Result<GenreListResponse, Error>) -> Void) {
        guard let url = URL(string: "\(baseUrl)/genre/movie/list?api_key=\(key)") else {
            completionHandler(.failure(ServiceError.urlDoesNotExist))
            return
        }
        
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data else {
                completionHandler(.failure(ServiceError.noDataFound))
                return
            }
            
            do {
                let response = try JSONDecoder().decode(GenreListResponse.self, from: data)
                completionHandler(.success(response))
            }
            catch {
                print(error)
                completionHandler(.failure(ServiceError.serializationFailed))
            }
        }.resume()
    }
    
    func fetchMoviesOfGenre(id: Int, completionHandler: @escaping (Result<MovieListResponse, Error>) -> Void) {
        guard let url = URL(string: "\(baseUrl)/discover/movie?api_key=\(self.key)&with_genres=\(id)") else {
            completionHandler(.failure(ServiceError.urlDoesNotExist))
            return
        }
        
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data else {
                completionHandler(.failure(ServiceError.noDataFound))
                return
            }
            
            do {
                let response = try JSONDecoder().decode(MovieListResponse.self, from: data)
                completionHandler(.success(response))
            }
            catch {
                print(error)
                completionHandler(.failure(ServiceError.serializationFailed))
            }
        }.resume()
    }
    
    func fetchMoviesDetail(id: Int, completionHandler: @escaping (Result<Movie, Error>) -> Void) {
        guard let url = URL(string: "\(baseUrl)/movie/\(id)?api_key=\(self.key)") else {
            completionHandler(.failure(ServiceError.urlDoesNotExist))
            return
        }
        
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data else {
                completionHandler(.failure(ServiceError.noDataFound))
                return
            }
            
            do {
                let response = try JSONDecoder().decode(Movie.self, from: data)
                completionHandler(.success(response))
            }
            catch {
                print(error)
                completionHandler(.failure(ServiceError.serializationFailed))
            }
        }.resume()

    }
}
