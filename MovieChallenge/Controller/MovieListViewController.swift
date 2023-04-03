//
//  ViewController.swift
//  MovieChallenge
//
//  Created by Tatiana Carvajal on 8/03/23.
//

import UIKit

class MovieListViewController: UIViewController {
    
    @IBOutlet var listTableView: UITableView!
    @IBOutlet var genresStackView: UIStackView!
    
    var service: ServiceProtocol = ServiceFacade()
    
    private var movies: [Movie] = []
    
    private var genres: [Genre] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadMovies()
        loadGenres()
        setupTableView()
    }
    
    private func loadMovies() {
        service.fetchTopRatedMovies { [weak self] result in
            switch result {
            case .success(let topRatedResponse):
                self?.movies = topRatedResponse.results
                DispatchQueue.main.async {
                    self?.listTableView.reloadData()
                }
            case .failure(_):
                DispatchQueue.main.async {
                    self?.showAlert()
                }
            }
        }
    }
    
    private func setupTableView() {
        listTableView.dataSource = self
        listTableView.delegate = self
        listTableView.register(UINib(nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieTableViewCell")
    }
    
    private func loadGenres() {
        service.fetchGenreListMovies { [weak self] result in
            switch result {
            case .success(let genreListResponse):
                DispatchQueue.main.async {
                    self?.genres = genreListResponse.genres
                    self?.selectGenres()
                }
            case .failure(_):
                DispatchQueue.main.async {
                    self?.showAlert()
                    
                }
            }
        }
    }
    
    private func selectGenres() {
        genres.forEach { genre in
            let button = GenreButton(title: genre.name, tag: genre.id) { [weak self] tag in
                self?.fetchMoviesForGenre(id: tag)
            }
            genresStackView.addArrangedSubview(button)
    
        }
    }
    
    private func fetchMoviesForGenre(id: Int) {
        service.fetchMoviesOfGenre(id: id) { [weak self] result in
            switch result {
            case .success(let moviesOfGenreResponse):
                self?.movies = moviesOfGenreResponse.results
                DispatchQueue.main.async {
                    self?.listTableView.reloadData()
                }
            case .failure(_):
                DispatchQueue.main.async {
                    self?.showAlert()
                }
            }
        }
    }
    
    func showAlert() {
        let alert: UIAlertController = UIAlertController(title: "Error", message: "Not Found", preferredStyle: .alert)
        let cancel: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }
}

extension MovieListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as? MovieTableViewCell else {
            return UITableViewCell()
        }
        let movie = movies[indexPath.row]
        cell.configureCell(image: "https://image.tmdb.org/t/p/w500\(movie.poster)", label: movie.title)
        return cell
         
    }
    
    
}
extension MovieListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = movies[indexPath.row]
        
        let storyboard = UIStoryboard(name: "DetailViewController", bundle: nil)
        guard let detailViewController = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else{
            return
        }
        detailViewController.movieId = movie.id
        
        if let navigationController = self.navigationController {
            navigationController.pushViewController(detailViewController, animated: true)
        } else {
            present(detailViewController, animated: true)
        }
    }
}
    

