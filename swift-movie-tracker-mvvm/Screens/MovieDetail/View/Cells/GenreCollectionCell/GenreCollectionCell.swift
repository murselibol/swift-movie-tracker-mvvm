//
//  GenreCollectionCell.swift
//  swift-movie-tracker-mvvm
//
//  Created by Mursel Elibol on 17.05.2023.
//

import UIKit

class GenreCollectionCell: UICollectionViewCell, NibProtocol, ReuseProtocol {

    @IBOutlet weak var genreButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    func configureUI() {
        genreButton.layer.cornerRadius = genreButton.frame.width * 0.1
        genreButton.layer.borderWidth = 0.8
        genreButton.layer.borderColor = UIColor.white.cgColor
    }
    
    func setup(genre: String) {
        genreButton.setTitle(genre, for: .normal)
    }

}
