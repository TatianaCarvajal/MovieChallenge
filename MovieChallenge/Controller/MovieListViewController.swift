//
//  ViewController.swift
//  MovieChallenge
//
//  Created by Tatiana Carvajal on 8/03/23.
//

import UIKit

class MovieListViewController: UIViewController {
    
    @IBOutlet var listTableView: UITableView!
    
    var service: ServiceProtocol = ServiceFacade()
    
    var movies: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadMovies()
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
            case .failure(let error): print(error)
            }
        }
    }
    private func setupTableView () {
        listTableView.dataSource = self
        listTableView.delegate = self
        listTableView.register(UINib(nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieTableViewCell")
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
        cell.configureCell(image: "https://image.tmdb.org/t/p/w55\(movie.poster)", label: movie.title)
        return cell
         
    }
    
    
}
extension MovieListViewController: UITableViewDelegate {
    
}
