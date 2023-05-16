//
//  GenreCollectionCell.swift
//  swift-movie-tracker-mvvm
//
//  Created by Mursel Elibol on 17.05.2023.
//

import UIKit

class GenreCollectionCell: UICollectionViewCell, NibProtocol, ReuseProtocol {

    @IBOutlet private weak var genreButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureGenreButton()
    }
    
    
    func configureGenreButton() {
        genreButton.layer.cornerRadius = 20
        genreButton.layer.borderWidth = 1
        genreButton.layer.borderColor = UIColor.systemBackground.cgColor
    }
    
    func setup(genre: String) {
        genreButton.titleLabel?.text = genre
    }

}
