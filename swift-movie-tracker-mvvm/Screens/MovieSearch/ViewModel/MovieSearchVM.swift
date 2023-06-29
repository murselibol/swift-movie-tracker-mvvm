//
//  MovieSearchVM.swift
//  swift-movie-tracker-mvvm
//
//  Created by Mursel Elibol on 27.05.2023.
//

import Foundation

protocol MovieSearchViewModelInterface {
    func viewDidLoad()
    func viewDidAppear()
    func searchTextFieldDidChangeSelection(searchText: String)
    func didSelectItem(at indexPath: IndexPath)
    func moviesTableWillDisplay()
}

final class MovieSearchVM {
    private weak var view: MovieSearchViewInterface?
    private let movieService: MovieServiceInterface
    var movies: [Movie] = []
    private var page: Int = 1
    
    init(view: MovieSearchViewInterface, movieService: MovieServiceInterface = MovieService.shared) {
        self.view = view
        self.movieService = movieService
    }
    private func resetMoviesTableData() {
        self.movies = []
        self.page = 1
        view?.moviesTableReloadData()
        self.changeVisibleItem(hide: .table)
    }
    
    private func changeVisibleItem(hide: SearchVisibleItem) {
        switch hide {
        case .placeholder:
            view?.hiddenMoviesTable(state: false)
            view?.hiddenPlaceholderTextView(state: true)
            break
        case .table:
            view?.hiddenMoviesTable(state: true)
            view?.hiddenPlaceholderTextView(state: false)
            break
        }
    }
    
    //MARK: - Network Functions
    private func getMoviesByName(text: String) {
        self.view?.startLoadingIndicator()
        movieService.getMoviesByName(name: text, page: page) { [weak self] res, error in
            guard let self = self else { return }
            
            if let error = error {
                print("Error: \(error.localizedDescription)")
                self.view?.stopLoadingIndicator()
                return
            }
            
            if let movies = res?.results {
                self.movies.append(contentsOf: movies)
                self.page += 1
                self.view?.moviesTableReloadData()
                if movies.count == 0 { self.changeVisibleItem(hide: .table) }
                self.view?.stopLoadingIndicator()
            }
        }
    }
    
}

extension MovieSearchVM: MovieSearchViewModelInterface {
    func viewDidLoad() {
        view?.stopLoadingIndicator()
        view?.configureVC()
        view?.configureSearchTextField()
        view?.configureMoviesTableView()
        view?.hiddenMoviesTable(state: true)
        view?.updatePlaceholder(text: "Sorry, no matches found for your search term.")
        self.changeVisibleItem(hide: .table)
    }
    
    func viewDidAppear(){
        view?.becomeFirstResponder()
    }
    
    func searchTextFieldDidChangeSelection(searchText: String) {
        resetMoviesTableData()
        guard searchText.count >= 3 else { return }
        self.changeVisibleItem(hide: .placeholder)
        let text = searchText.replacingOccurrences(of: " ", with: "+")
        getMoviesByName(text: text)
    }
    
    func didSelectItem(at indexPath: IndexPath) {
        guard let movieId = movies[indexPath.row].id else { return }
        let movieDetailVC = MovieDetailVC(id: movieId)
        self.view?.navigateController(vc: movieDetailVC, animate: true)
    }
    
    func moviesTableWillDisplay(){
        guard let searchText = view?.searchText else { return }
        getMoviesByName(text: searchText)
    }

}
