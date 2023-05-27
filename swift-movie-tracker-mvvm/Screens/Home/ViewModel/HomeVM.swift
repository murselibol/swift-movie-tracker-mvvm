//
//  HomeVM.swift
//  swift-movie-tracker-mvvm
//
//  Created by Mursel Elibol on 4.05.2023.
//

import Foundation

enum MoviesSectionType {
    case highlight
    case category
}

protocol HomeViewModelInterface {
    var view: HomeViewInterface? { get set }
    
    func viewDidLoad()
    func openFilterSheet()
    func navigateSearchVC()
    func didSelectItem(at indexPath: IndexPath, cellType: MoviesSectionType)
}

final class HomeVM {
    weak var view: HomeViewInterface?
    private let service = MovieService()
    
    var trendingMovies: [Movie] = []
    var selectedCategoryMovies: [Movie] = []
    var selectedMovieCategory: MovieCategory = .nowPlaying
    private var categoryTitle: String {
        switch selectedMovieCategory {
        case .nowPlaying:
            return "Now Playing"
        case .popular:
            return "Popular"
        case .trending:
            return "Trending"
        case .topRated:
            return "Top Rated"
        case .upcoming:
            return "Up Coming"
        }
    }
    
    var timer = Timer()
    var pageControlIndex = 0
    
    
    //MARK: - Functions
    func startCollectionTimer() {
        self.timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(moveToNextIndex), userInfo: nil, repeats: true)
        RunLoop.main.add(timer, forMode: RunLoop.Mode.common)
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
    
    func getSelectedMovieId(index: Int, type: MoviesSectionType) -> Int? {
        switch type {
        case .highlight:
            return trendingMovies[index].id
        case .category:
            return selectedCategoryMovies[index].id
        }
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
        service.getMoviesByCategory(categoryName: selectedMovieCategory) { [weak self] movies, error in
            guard let self = self else { return }
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            if let movies = movies {
                self.selectedCategoryMovies = movies.results ?? []
                self.view?.updateMoviesTableTitle(title: self.categoryTitle)
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
    
    func openFilterSheet() {
        let filterSheet = FilterSheet()
        filterSheet.viewModel.homeViewModel = self
        if let sheet = filterSheet.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.preferredCornerRadius = 24
            sheet.prefersGrabberVisible = true
        }
        
        self.view?.navigatePresent(vc: filterSheet)
    }
    
    func navigateSearchVC() {
        self.view?.navigateController(vc: HomeVC())
    }
    
    func didSelectItem(at indexPath: IndexPath, cellType: MoviesSectionType) {
        guard let movieId = getSelectedMovieId(index: indexPath.row, type: cellType) else { return }
        let movieDetailVC = MovieDetailVC(id: movieId)
        self.view?.navigateController(vc: movieDetailVC)
    }
}
