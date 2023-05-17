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
    
    var movie: MovieModel?
    
    func getMovie(id: Int) {
        service.getMovie(id: id) { [weak self] movie, error in
            guard let self = self else { return }
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            if let movie = movie {
                self.movie = movie
            }
        }
    }
    
}

extension MovieDetailVM: MovieDetailViewModelInterface {
    func viewDidLoad() {
        
        guard let movieId = view?.movieId else { return }
        getMovie(id: movieId)
    }
    
    
}
