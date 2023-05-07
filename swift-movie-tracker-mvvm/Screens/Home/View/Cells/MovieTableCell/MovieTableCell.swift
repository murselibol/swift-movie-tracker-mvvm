//
//  MovieTableCell.swift
//  swift-movie-tracker-mvvm
//
//  Created by Mursel Elibol on 7.05.2023.
//

import UIKit

class MovieTableCell: UITableViewCell, NibProtocol, ReuseProtocol {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var imdbLabel: UILabel!
    @IBOutlet weak var posterImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    func configureUI() {
        posterImage.layer.cornerRadius = 8
    }
    
    func setup(movie: Movie) {
        titleLabel.text = movie.originalTitle
        summaryLabel.text = movie.overview
        imdbLabel.text = "\(movie.voteAverage ?? 0) / 10 IMDB"
        guard let imagePath = movie.posterPath else {
            posterImage.loadURL(url: K.notFoundMovieImage)
            return
        }
        posterImage.loadURLWithCdn(url: imagePath)
    }
    
}
