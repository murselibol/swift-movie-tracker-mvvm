//
//  HighlightCollectionCell.swift
//  swift-movie-tracker-mvvm
//
//  Created by Mursel Elibol on 4.05.2023.
//

import UIKit

final class HighlightCollectionCell: UICollectionViewCell, NibProtocol, ReuseProtocol {
    
    @IBOutlet private weak var posterImage: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func setup(title: String) {
        titleLabel.text = title
    }

}
