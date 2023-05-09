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
    
    var presenter: DetailPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.delegate = self
        presenter?.fetchDetailMovie()
    }
}

extension DetailViewController: DetailDelegate {
    func movieDetail() {
        DispatchQueue.main.async {
            guard let movie = self.presenter?.movie else{
                return
            }
            self.titleLabel.text = movie.title
            self.descriptionTextView.isEditable = false
            self.descriptionTextView.text = movie.overview
            self.descriptionTextView.font = UIFont.systemFont(ofSize: 16)
            self.popularityLabel.text = self.presenter?.getMoviePopularity()
            if let url = self.presenter?.getMoviePoster() {
                self.movieImageView.load(url: url)
            }
        }
    }
    
    func showError() {
        DispatchQueue.main.async {
            let alert: UIAlertController = UIAlertController(title: "Error", message: "Not Found", preferredStyle: .alert)
            let cancel: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel)
                alert.addAction(cancel)
            self.present(alert, animated: true, completion: nil)
        }
    }
}
