//
//  MovieTableViewCell.swift
//  MovieChallenge
//
//  Created by Tatiana Carvajal on 11/03/23.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    @IBOutlet var movieImage: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
     
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    func configureCell(image: String, label: String) {
        titleLabel.text = label
        guard let url = URL(string: image) else {
            return
        }
        movieImage.load(url: url)
    }
}
