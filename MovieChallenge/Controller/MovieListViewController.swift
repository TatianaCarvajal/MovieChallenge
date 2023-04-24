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
    
    var presenter: MovieListPresenter = MovieListPresenter(service: ServiceFacade())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.delegate = self
        presenter.loadMovies()
        presenter.loadGenres()
        setupTableView()
    }

    private func setupTableView() {
        listTableView.dataSource = self
        listTableView.delegate = self
        listTableView.register(UINib(nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieTableViewCell")
    }
    
    private func selectGenres() {
        presenter.genres.forEach { genre in
            let button = GenreButton(title: genre.name, tag: genre.id) { [weak self] tag in
                self?.presenter.fetchMoviesForGenre(id: tag)
            }
            genresStackView.addArrangedSubview(button)
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
        return presenter.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as? MovieTableViewCell else {
            return UITableViewCell()
        }
        
        let (poster, title) = presenter.getMoviePosterAndTitle(pos: indexPath.row)
        cell.configureCell(image: poster, label: title)
        return cell
    }
    
    
}
extension MovieListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailViewController = presenter.getDetailViewController(pos: indexPath.row)
        
        if let navigationController = self.navigationController {
            navigationController.pushViewController(detailViewController, animated: true)
        } else {
            present(detailViewController, animated: true)
        }
    }
}

extension MovieListViewController: MovieListDelegate {
    func showGenres() {
        DispatchQueue.main.async {
            self.selectGenres()
        }
    }
    
    func reloadView() {
        DispatchQueue.main.async {
            self.listTableView.reloadData()
        }
    }
    
    func showError() {
        DispatchQueue.main.async {
            self.showAlert()
        }
    }
}

