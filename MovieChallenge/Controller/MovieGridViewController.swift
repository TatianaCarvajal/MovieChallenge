//
//  MovieGridViewController.swift
//  MovieChallenge
//
//  Created by Tatiana Carvajal on 28/03/23.
//

import UIKit

class MovieGridViewController: UIViewController {
    
    @IBOutlet var gridCollectionView: UICollectionView!
    
    var service: ServiceProtocol = ServiceFacade()
    
    private var movies: [Movie] = []
    
    private let cellWidth = UIScreen.main.bounds.width / 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadMovies()
        setupCollectionView()
    }
    
    private func loadMovies() {
        service.fetchTopRatedMovies { [weak self] result in
            switch result {
            case .success(let topRatedResponse):
                self?.movies = topRatedResponse.results
                DispatchQueue.main.async {
                    self?.gridCollectionView.reloadData()
                }
            case .failure(_):
                DispatchQueue.main.async {
                   self?.showAlert()
                    
                }
            }
        }
    }
    
    private func setupCollectionView() {
        gridCollectionView.dataSource = self
        gridCollectionView.delegate = self
        gridCollectionView.register(UINib(nibName: "MovieCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MovieCollectionViewCell")
    }
    
    func showAlert() {
        let alert: UIAlertController = UIAlertController(title: "Error", message: "Not Found", preferredStyle: .alert)
        let cancel: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }
}

extension MovieGridViewController: UICollectionViewDataSource {
    
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return movies.count
        }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionViewCell", for: indexPath) as? MovieCollectionViewCell else {
            return UICollectionViewCell()
        }
        let movie = movies[indexPath.row]
        cell.configureCell(image: "https://image.tmdb.org/t/p/w500\(movie.poster)", label: movie.title)
        return cell
    }
}

extension MovieGridViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
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

extension MovieGridViewController: UICollectionViewDelegateFlowLayout {
    
    func CollectionView(_collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt Indexpath: IndexPath) -> CGSize {
        
        return CGSize(width: cellWidth, height: cellWidth)
    }
    

}
