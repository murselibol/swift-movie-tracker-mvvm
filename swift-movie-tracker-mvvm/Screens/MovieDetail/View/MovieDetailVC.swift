//
//  MovieDetailVC.swift
//  swift-movie-tracker-mvvm
//
//  Created by Mursel Elibol on 11.05.2023.
//

import UIKit

protocol MovieDetailViewInterface: AnyObject {
    var movieId: Int { get }
    
    func configureMovieData(movie: MovieModel)
}

class MovieDetailVC: UIViewController {
    
    @IBOutlet weak var backdropImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imdbLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var genreCollectionView: UICollectionView!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var castCollectionView: UICollectionView!
    
    
    var movieId: Int
    private lazy var viewModel = MovieDetailVM()
    
    
    init(id: Int) {
        self.movieId = id
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.view = self
        viewModel.viewDidLoad()
    }
}


extension MovieDetailVC: MovieDetailViewInterface {
    func configureMovieData(movie: MovieModel) {
        backdropImage.loadURLWithCdn(url: movie.backdropPath)
        titleLabel.text = movie.originalTitle
        imdbLabel.text = String(format: "%.1f", movie.voteAverage)+"/10 IMDb"
        timeLabel.text = "\(movie.runtime) Minutes"
        releaseDateLabel.text = "\(movie.releaseDate.prefix(4))"
    }
}
