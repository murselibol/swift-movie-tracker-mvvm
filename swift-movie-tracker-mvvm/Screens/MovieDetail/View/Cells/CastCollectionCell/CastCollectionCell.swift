//
//  CastCollectionCell.swift
//  swift-movie-tracker-mvvm
//
//  Created by Mursel Elibol on 27.05.2023.
//

import UIKit

final class CastCollectionCell: UICollectionViewCell, NibProtocol, ReuseProtocol {

    @IBOutlet private weak var castImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    func configureUI() {
        castImage.layer.cornerRadius = 6
    }
    
    func setup(cast: Cast) {
        guard let imagePath = cast.profilePath else {
            castImage.loadURL(url: K.userPlaceholderImage)
            return
        }
        castImage.loadURLWithCdn(url: imagePath)
    }

}
