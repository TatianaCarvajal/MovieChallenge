//
//  DetailPresenter.swift
//  MovieChallenge
//
//  Created by Tatiana Carvajal on 8/05/23.
//

import Foundation

protocol DetailDelegate: AnyObject {
    func movieDetail()
    func showError()
}

class DetailPresenter {
    
    private let service: ServiceProtocol
    private(set) var movieId: Int
    private(set) var movie: Movie?
    weak var delegate: DetailDelegate?
    
    init(service: ServiceProtocol, movieId: Int) {
        self.service = service
        self.movieId = movieId
    }
    
    func fetchDetailMovie() {
        service.fetchMoviesDetail(id: movieId) { [weak self] result in
            switch result {
            case .success(let movieDetail):
                self?.movie = movieDetail
                self?.delegate?.movieDetail()
            case .failure(_):
                self?.delegate?.showError()
            }
        }
    }
    
    func getMoviePoster() -> URL? {
        guard let poster = movie?.poster else  {
            return nil
        }
        
        return URL(string: "https://image.tmdb.org/t/p/w500\(poster)")
    }
    
    func getMoviePopularity() -> String? {
        guard let popularity = movie?.popularity else {
            return nil
        }
        return "Popularity \(popularity)"
    }
}


