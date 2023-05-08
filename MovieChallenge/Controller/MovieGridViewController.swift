//
//  MovieGridViewController.swift
//  MovieChallenge
//
//  Created by Tatiana Carvajal on 28/03/23.
//

import UIKit

class MovieGridViewController: UIViewController {
    
    @IBOutlet private var genreStackView: UIStackView!
    @IBOutlet private var gridCollectionView: UICollectionView!

    var presenter: MovieGridPresenter = MovieGridPresenter(service: ServiceFacade())
    
    private let cellWidth = UIScreen.main.bounds.width / 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.delegate = self
        presenter.loadMovies()
        presenter.loadGenres()
        setupCollectionView()
    }
    
    
    private func setupCollectionView() {
        gridCollectionView.dataSource = self
        gridCollectionView.delegate = self
        gridCollectionView.register(UINib(nibName: "MovieCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MovieCollectionViewCell")
    }
    
  
    
    private func selectGenres() {
        presenter.genres.forEach { genre in
            let button = GenreButton(title: genre.name, tag: genre.id) { [weak self] tag in
                self?.presenter.fetchMoviesForGenre(id: tag)
            }
            genreStackView.addArrangedSubview(button)
    
        }
    }
    
    
   private func showAlert() {
        let alert: UIAlertController = UIAlertController(title: "Error", message: "Not Found", preferredStyle: .alert)
        let cancel: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }
    
}

extension MovieGridViewController: UICollectionViewDataSource {
    
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.movies.count
        }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionViewCell", for: indexPath) as? MovieCollectionViewCell else {
            return UICollectionViewCell()
        }
        let (poster, title) = presenter.getMoviePosterAndTitle(pos: indexPath.row)
        cell.configureCell(image: poster, label: title)
        return cell
    }
}

extension MovieGridViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let detailViewController = presenter.createDetailViewController(pos: indexPath.row)

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

extension MovieGridViewController: MovieGridDelegate {
    func reloadView() {
        DispatchQueue.main.async {
            self.selectGenres()
        }
    }
    
    func showGenres() {
        DispatchQueue.main.async {
            self.gridCollectionView.reloadData()
        }
    }
    
    func showError() {
        DispatchQueue.main.async {
            self.showAlert()
        }
    }
    
    
}
