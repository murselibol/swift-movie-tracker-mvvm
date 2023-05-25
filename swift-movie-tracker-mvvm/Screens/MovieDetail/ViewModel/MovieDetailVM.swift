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
    private let service = MovieService()
    private let castService = CastService()
    
    var movie: MovieModel?
    var casts: [Cast]?
    
    func getMovie(id: Int) {
        service.getMovie(id: id) { [weak self] res, error in
            guard let self = self else { return }
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            if let movie = res {
                self.movie = movie
                self.view?.configureMovieData(movie: movie)
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
            }
        }
    }
    
}

extension MovieDetailVM: MovieDetailViewModelInterface {
    func viewDidLoad() {
        view?.configureCastCollectionView()
        
        guard let movieId = view?.movieId else { return }
        getMovie(id: movieId)
        getCasts(id: movieId)
    }
}
