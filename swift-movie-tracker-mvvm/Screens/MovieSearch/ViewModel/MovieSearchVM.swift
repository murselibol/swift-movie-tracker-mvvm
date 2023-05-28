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
    func searchTextFieldDidChangeSelection(searchText: String)
    func didSelectItem(at indexPath: IndexPath)
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
        view?.configureSearchTextField()
        view?.configureMoviesTableView()
    }
    
    func searchTextFieldDidChangeSelection(searchText: String) {
        if searchText == "" {
            getMoviesByName(text: searchText)
            return
        }
        guard searchText.count > 2 else { return }

        let text = searchText.replacingOccurrences(of: " ", with: "+")
        getMoviesByName(text: text)
    }
    func didSelectItem(at indexPath: IndexPath) {
        guard let movieId = movies[indexPath.row].id else { return }
        let movieDetailVC = MovieDetailVC(id: movieId)
        self.view?.navigateController(vc: movieDetailVC, animate: true)
    }
    

}
