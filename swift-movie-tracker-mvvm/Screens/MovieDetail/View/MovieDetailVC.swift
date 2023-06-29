//
//  MovieDetailVC.swift
//  swift-movie-tracker-mvvm
//
//  Created by Mursel Elibol on 11.05.2023.
//

import UIKit
import youtube_ios_player_helper

protocol MovieDetailViewInterface: AnyObject {
    var movieId: Int { get }
    
    func configureVC()
    func configureGenreCollectionView()
    func genreReloadData()
    func configureCastCollectionView()
    func castReloadData()
    func loadYoutubePlayerVideo(id: String)
    
    func configureMovieData(movie: MovieModel)
}

final class MovieDetailVC: UIViewController {
    
    @IBOutlet private weak var backdropImage: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var imdbLabel: UILabel!
    @IBOutlet private weak var timeLabel: UILabel!
    @IBOutlet private weak var releaseDateLabel: UILabel!
    @IBOutlet private weak var genreCollectionView: UICollectionView!
    @IBOutlet private weak var overviewLabel: UILabel!
    @IBOutlet private weak var castCollectionView: UICollectionView!
    @IBOutlet private weak var youtubePlayerView: YTPlayerView!
    
    var movieId: Int
    private lazy var viewModel = MovieDetailVM(view: self)
    
    
    init(id: Int) {
        self.movieId = id
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.viewDidLoad()
    }
}


extension MovieDetailVC: MovieDetailViewInterface {
    func configureVC() {
        self.navigationController?.setCustomBackButton(imageName: "chevron.backward.circle")
    }
    
    func configureMovieData(movie: MovieModel) {
        backdropImage.loadURLWithCdn(url: movie.backdropPath)
        titleLabel.text = movie.originalTitle
        imdbLabel.text = String(format: "%.1f", movie.voteAverage)+"/10 IMDb"
        timeLabel.text = "\(movie.runtime) Minutes"
        releaseDateLabel.text = "\(movie.releaseDate.prefix(4))"
    }
    
    func configureGenreCollectionView() {
        genreCollectionView.delegate = self
        genreCollectionView.dataSource = self
        genreCollectionView.registerCell(type: GenreCollectionCell.self)
        
        if let layout = genreCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
    }
    
    func genreReloadData () {
        genreCollectionView.reloadData()
    }
    
    func configureCastCollectionView() {
        castCollectionView.delegate = self
        castCollectionView.dataSource = self
        castCollectionView.registerCell(type: CastCollectionCell.self)
    }
    
    func castReloadData () {
        castCollectionView.reloadData()
    }
    
    func loadYoutubePlayerVideo(id: String) {
        youtubePlayerView.load(withVideoId: id)
    }
}

//MARK: - UICollectionView
extension MovieDetailVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case genreCollectionView:
            return viewModel.movie?.genres.count ?? 0
        case castCollectionView:
            return viewModel.casts?.count ?? 0
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case genreCollectionView:
            let cell: GenreCollectionCell = genreCollectionView.dequeueCell(for: indexPath)
            cell.setup(genre: viewModel.movie?.genres[indexPath.item].name ?? "N/A")
            return cell
        case castCollectionView:
            let cell: CastCollectionCell = castCollectionView.dequeueCell(for: indexPath)
            cell.setup(cast: viewModel.casts![indexPath.item])
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case castCollectionView:
            return CGSize(width: collectionView.frame.height * 0.9, height: collectionView.frame.height)
        default:
            return CGSize()
        }
    }
}
