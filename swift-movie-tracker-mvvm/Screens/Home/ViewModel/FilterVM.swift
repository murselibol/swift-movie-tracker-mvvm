//
//  FilterVM.swift
//  swift-movie-tracker-mvvm
//
//  Created by Mursel Elibol on 8.05.2023.
//

import Foundation

protocol FilterViewModelInterface {
    var homeViewModel: HomeVM { get set }
    
    func viewDidLoad()
    func tableDidSelectRow(at indexPath: IndexPath)
}

final class FilterVM {
    
    private weak var view: FilterSheetInterface?
    var homeViewModel = HomeVM(view: HomeVC())

    var filterItems = [
        FilterModel(title: "Now Playing", type: .nowPlaying),
        FilterModel(title: "Popular", type: .popular),
        FilterModel(title: "Top Rated", type: .topRated),
        FilterModel(title: "Upcoming", type: .upcoming)
    ]
    
    init(view: FilterSheetInterface) {
        self.view = view
    }

}

extension FilterVM: FilterViewModelInterface {
    func viewDidLoad() {
        view?.configureTableView()
    }
    
    func tableDidSelectRow(at indexPath: IndexPath) {
        let category: FilterModel = filterItems[indexPath.row]
        homeViewModel.selectedMovieCategory = category.type
        homeViewModel.fetchMoviesByCategory()
    }

}
