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
            let button = UIButton(type: .system)
            button.setTitle(genre.name, for: .normal)
            button.tag = genre.id
            button.setTitleColor(.black, for: .normal)
            button.backgroundColor = .lightGray
            button.layer.cornerRadius = 12
            button.addTarget(self, action: #selector(pressed(_:)), for: .touchUpInside)
            genresStackView.addArrangedSubview(button)
    
        }
    }
    @objc func pressed(_ sender: UIButton) {
        service.fetchMoviesOfGenre(id: sender.tag) { [weak self] result in
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
                print("error")
                
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
    
}
