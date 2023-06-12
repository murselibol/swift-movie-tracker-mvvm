//
//  GenreCollectionCell.swift
//  swift-movie-tracker-mvvm
//
//  Created by Mursel Elibol on 17.05.2023.
//

import UIKit

final class GenreCollectionCell: UICollectionViewCell, NibProtocol, ReuseProtocol {

    @IBOutlet private weak var genreButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    func configureUI() {
        genreButton.layer.cornerRadius = genreButton.frame.width * 0.1
        genreButton.layer.borderWidth = 1
        genreButton.layer.borderColor = UIColor.getColor(color: .primaryColor)
    }
    
    func setup(genre: String) {
        genreButton.setTitle(genre, for: .normal)
    }

}
