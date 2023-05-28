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
    
}

extension MovieDetailVM: MovieDetailViewModelInterface {
    func viewDidLoad() {
        view?.configureGenreCollectionView()
        view?.configureCastCollectionView()
        
        guard let movieId = view?.movieId else { return }
        getMovie(id: movieId)
        getCasts(id: movieId)
    }
}
