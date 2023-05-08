//
//  HomeVM.swift
//  swift-movie-tracker-mvvm
//
//  Created by Mursel Elibol on 4.05.2023.
//

import Foundation

protocol HomeViewModelInterface {
    var view: HomeViewInterface? { get set }
    
    func viewDidLoad()
}

final class HomeVM {
    weak var view: HomeViewInterface?
    private let service = MovieService()
    
    var trendingMovies: [Movie] = []
    var selectedCategoryMovies: [Movie] = []
    private let selectedMovieCategory: MovieCategory = .nowPlaying
    private var timer = Timer()
    var pageControlIndex = 0
    
    
    
    func startCollectionTimer() {
        self.timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(moveToNextIndex), userInfo: nil, repeats: true)
    }
    
    @objc func moveToNextIndex() {
        if pageControlIndex < trendingMovies.count {
            updateCollectionIndex()
            pageControlIndex += 1
        } else {
            pageControlIndex = 0
            updateCollectionIndex()
            pageControlIndex = 1
        }
    }
    
    func updateCollectionIndex(){
        let indexPath = IndexPath.init(item: pageControlIndex, section: 0)
        view?.collectionPagingDisabled()
        view?.collectionScrollToItem(at: indexPath)
        view?.collectionPagingEnabled()
    }
    
    //MARK: - Network Functions
    func fetchTrendingMovies() {
        service.getMoviesByCategory(categoryName: .trending) { [weak self] movies, error in
            guard let self = self else { return }
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            if let movies = movies {
                self.trendingMovies = movies.results ?? []
                self.view?.collectionReloadData()
                self.startCollectionTimer()
            }
        }
    }
    
    func fetchMoviesByCategory(){
        service.getMoviesByCategory(categoryName: .nowPlaying) { [weak self] movies, error in
            guard let self = self else { return }
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            if let movies = movies {
                self.selectedCategoryMovies = movies.results ?? []
                self.view?.tableReloadData()
            }
        }
    }
    
}

//MARK: - HomeViewModelInterface
extension HomeVM: HomeViewModelInterface {
    func viewDidLoad() {
        view?.configureVC()
        view?.configureNavigationBar()
        view?.configureCollectionView()
        view?.configureTableView()
        fetchTrendingMovies()
        fetchMoviesByCategory()
    }
}
