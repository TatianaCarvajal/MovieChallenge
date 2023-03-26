//
//  DetailViewController.swift
//  MovieChallenge
//
//  Created by Tatiana Carvajal on 20/03/23.
//

import UIKit

class DetailViewController: UIViewController {
   
    @IBOutlet var movieImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionTextView: UITextView!
    @IBOutlet var popularityLabel: UILabel!
    
    var service: ServiceProtocol = ServiceFacade()
    var movieId: Int = 0
    var movie: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchDetailMovie()
    }
    
    private func setUpView() {
        guard let movie = movie else{
            return
        }
        titleLabel.text = movie.title
        descriptionTextView.isEditable = false
        descriptionTextView.text = movie.overview
        descriptionTextView.font = UIFont.systemFont(ofSize: 16)
        popularityLabel.text = "Popularity \(movie.popularity)"
        if let url = URL(string: "https://image.tmdb.org/t/p/w500\(movie.poster)") {
            movieImageView.load(url: url)
        }
    }
    
    private func fetchDetailMovie() {
        service.fetchMoviesDetail(id: movieId) { [weak self] result in
            switch result {
            case .success(let movieDetail):
                DispatchQueue.main.async {
                    self?.movie = movieDetail
                    self?.setUpView()
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

