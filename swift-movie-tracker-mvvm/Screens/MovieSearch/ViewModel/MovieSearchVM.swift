//
//  MovieSearchVM.swift
//  swift-movie-tracker-mvvm
//
//  Created by Mursel Elibol on 27.05.2023.
//

import Foundation

protocol MovieSearchViewModelInterface {
    var view: MovieSearchViewInterface? { get set }
    
    func viewDidLoad()
}

final class MovieSearchVM {
    var view: MovieSearchViewInterface?
    private let movieService = MovieService()
    var movies: [Movie] = []
    
    //MARK: - Network Functions
    func getMoviesByName(text: String) {
        movieService.getMoviesByName(name: text) { [weak self] movies, error in
            guard let self = self else { return }
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            if let movies = movies {
                self.movies = movies.results ?? []
                self.view?.moviesTableReloadData()
            }
        }
    }
    
}

extension MovieSearchVM: MovieSearchViewModelInterface {
    func viewDidLoad() {
        print("viewDidLoad")
        view?.configureMoviesTableView()
        getMoviesByName(text: "John")
    }
    
}
