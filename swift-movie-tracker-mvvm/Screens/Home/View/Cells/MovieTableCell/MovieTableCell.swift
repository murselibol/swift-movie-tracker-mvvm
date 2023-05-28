//
//  MovieTableCell.swift
//  swift-movie-tracker-mvvm
//
//  Created by Mursel Elibol on 7.05.2023.
//

import UIKit

final class MovieTableCell: UITableViewCell, NibProtocol, ReuseProtocol {
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var summaryLabel: UILabel!
    @IBOutlet private weak var imdbLabel: UILabel!
    @IBOutlet private weak var posterImage: UIImageView!
    
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
        imdbLabel.text = String(format: "%.1f", movie.voteAverage ?? 0)+"/10 IMDb"
        guard let imagePath = movie.posterPath else {
            posterImage.loadURL(url: K.notFoundMovieImage)
            return
        }
        posterImage.loadURLWithCdn(url: imagePath)
    }
    
}
