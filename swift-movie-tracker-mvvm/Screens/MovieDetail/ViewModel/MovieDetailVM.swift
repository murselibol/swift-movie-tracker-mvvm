//
//  MovieDetailVM.swift
//  swift-movie-tracker-mvvm
//
//  Created by Mursel Elibol on 11.05.2023.
//

import Foundation

protocol MovieDetailViewModelInterface {
    var view: MovieDetailViewInterface? { get set }
    
    func viewDidLoad()
}

final class MovieDetailVM {
    weak var view: MovieDetailViewInterface?
    private let movieService = MovieService()
    private let castService = CastService()
    
    var movie: MovieModel?
    var casts: [Cast]?
    var videos: [MovieVideo]?
    
    func getMovie(id: Int) {
        movieService.getMovie(id: id) { [weak self] res, error in
            guard let self = self else { return }
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            if let movie = res {
                self.movie = movie
                self.view?.configureMovieData(movie: movie)
                self.view?.genreReloadData()
            }
        }
    }
    
    func getCasts(id: Int) {
        castService.getCasts(movieId: id) { [weak self] res, error in
            guard let self = self else { return }
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            if let casts = res {
                self.casts = casts.cast
                self.view?.castReloadData()
            }
        }
    }
    
    func getVideos(id: Int) {
        movieService.getVideos(id: id) { [weak self] res, error in
            guard let self = self else { return }
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            if let videos = res {
                self.videos = videos.results
                guard let video = self.videos, !video.isEmpty else { return }
                self.view?.loadYoutubePlayerVideo(id: video[0].key)
            }
        }
    }
    
}

extension MovieDetailVM: MovieDetailViewModelInterface {
    func viewDidLoad() {
        view?.configureVC()
        view?.configureGenreCollectionView()
        view?.configureCastCollectionView()
        
        guard let movieId = view?.movieId else { return }
        getMovie(id: movieId)
        getCasts(id: movieId)
        getVideos(id: movieId)
    }
    
    
}
