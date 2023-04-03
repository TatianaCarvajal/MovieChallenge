//
//  MovieCollectionViewCell.swift
//  MovieChallenge
//
//  Created by Tatiana Carvajal on 28/03/23.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var movieImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    func configureCell(image: String, label: String) {
        titleLabel.text = label
        guard let url = URL(string: image) else {
            return
        }
        movieImage.load(url: url)
    }
}
