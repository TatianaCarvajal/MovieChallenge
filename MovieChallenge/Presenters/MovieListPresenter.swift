//
//  MovieListPresenter.swift
//  MovieChallenge
//
//  Created by Tatiana Carvajal on 24/04/23.
//

import Foundation
import UIKit

protocol MovieListDelegate: AnyObject {
    func reloadView()
    func showGenres()
    func showError()
}

class MovieListPresenter {
    let service: ServiceProtocol
    var movies: [Movie] = []
    var genres: [Genre] = []
    weak var delegate: MovieListDelegate?
    
    init(service: ServiceProtocol) {
        self.service = service
    }
    
    func loadMovies() {
        service.fetchTopRatedMovies { [weak self] result in
            switch result {
            case .success(let topRatedResponse):
                self?.movies = topRatedResponse.results
                self?.delegate?.reloadView()
            case .failure(_):
                self?.delegate?.showError()
            }
        }
    }
    
    func loadGenres() {
        service.fetchGenreListMovies { [weak self] result in
            switch result {
            case .success(let genreListResponse):
                self?.genres = genreListResponse.genres
                self?.delegate?.showGenres()
            case .failure(_):
                self?.delegate?.showError()
            }
        }
    }
    
    func fetchMoviesForGenre(id: Int) {
        service.fetchMoviesOfGenre(id: id) { [weak self] result in
            switch result {
            case .success(let moviesOfGenreResponse):
                self?.movies = moviesOfGenreResponse.results
                self?.delegate?.reloadView()
            case .failure(_):
                self?.delegate?.showError()
            }
        }
    }
    
    func getMoviePosterAndTitle(pos: Int) -> (String, String) {
        let movie = self.movies[pos]
        return ("https://image.tmdb.org/t/p/w500\(movie.poster)", movie.title)
    }
    
    func getDetailViewController(pos: Int) -> UIViewController {
        let movie = movies[pos]
        
        let storyboard = UIStoryboard(name: "DetailViewController", bundle: nil)
        guard let detailViewController = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else{
            return UIViewController()
        }
        detailViewController.movieId = movie.id
        
        return detailViewController
    }
}
