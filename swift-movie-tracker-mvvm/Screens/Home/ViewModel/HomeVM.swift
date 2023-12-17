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
    func viewDidLoad()
    func changeThemeMode(currentTheme: ThemeMode)
    func openFilterSheet()
    func navigateSearchVC()
    func didSelectItem(at indexPath: IndexPath, cellType: MoviesSectionType)
}

final class HomeVM {
    private weak var view: HomeViewInterface?
    private let movieService: MovieServiceInterface
    
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
    
    init(view: HomeViewInterface, movieService: MovieServiceInterface = MovieService.shared) {
        self.view = view
        self.movieService = movieService
    }
    
    
    //MARK: - Functions
    func startCollectionTimer() {
        self.timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(moveToNextIndex), userInfo: nil, repeats: true)
        RunLoop.main.add(timer, forMode: RunLoop.Mode.common)
    }
    
    @objc private func moveToNextIndex() {
        if pageControlIndex < trendingMovies.count {
            updateCollectionIndex()
            pageControlIndex += 1
        } else {
            pageControlIndex = 0
            updateCollectionIndex()
            pageControlIndex = 1
        }
    }
    
    private func updateCollectionIndex() {
        let indexPath = IndexPath.init(item: pageControlIndex, section: 0)
        view?.collectionPagingDisabled()
        view?.collectionScrollToItem(at: indexPath)
        view?.collectionPagingEnabled()
    }
    
    private func getSelectedMovieId(index: Int, type: MoviesSectionType) -> Int? {
        switch type {
        case .highlight:
            return trendingMovies[index].id
        case .category:
            return selectedCategoryMovies[index].id
        }
    }
    
    
    //MARK: - Network Functions
    func fetchTrendingMovies() {
        movieService.getMoviesByCategory(categoryName: .trending) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                self.trendingMovies = data.results ?? []
                self.view?.collectionReloadData()
                self.startCollectionTimer()
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func fetchMoviesByCategory() {
        movieService.getMoviesByCategory(categoryName: selectedMovieCategory) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                self.selectedCategoryMovies = data.results ?? []
                self.view?.updateMoviesTableTitle(title: self.categoryTitle)
                self.view?.tableReloadData()
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
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
    
    func changeThemeMode(currentTheme: ThemeMode) {
        if currentTheme == .dark {
            ThemeMode.mode = .light
            view?.changeThemeBarButtonImage(imageName: "moon.stars.fill")
        } else {
            ThemeMode.mode = .dark
            view?.changeThemeBarButtonImage(imageName: "sun.max.fill")
        }
    }
    
    func openFilterSheet() {
        let filterSheet = FilterSheet()
        filterSheet.viewModel.homeViewModel = self
        if let sheet = filterSheet.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.preferredCornerRadius = 24
            sheet.prefersGrabberVisible = true
        }
        
        self.view?.navigatePresent(vc: filterSheet, animate: true)
    }
    
    func navigateSearchVC() {
        self.view?.navigateController(vc: MovieSearchVC(), animate: true)
    }
    
    func didSelectItem(at indexPath: IndexPath, cellType: MoviesSectionType) {
        guard let movieId = getSelectedMovieId(index: indexPath.row, type: cellType) else { return }
        let movieDetailVC = MovieDetailVC(id: movieId)
        self.view?.navigateController(vc: movieDetailVC, animate: true)
    }
}


