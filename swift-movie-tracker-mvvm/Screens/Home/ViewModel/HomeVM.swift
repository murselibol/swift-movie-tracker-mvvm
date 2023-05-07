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
    
    var movies = [1,2,3,4,5,6,7,8,9]
    
    private var timer = Timer()
    var pageControlIndex = 0
    
    func startCollectionTimer() {
        self.timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(moveToNextIndex), userInfo: nil, repeats: true)
    }
    
    @objc func moveToNextIndex() {
        if pageControlIndex < movies.count {
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
    
}

//MARK: - HomeViewModelInterface
extension HomeVM: HomeViewModelInterface {
    func viewDidLoad() {
        view?.configureCollectionView()
        startCollectionTimer()
    }
}
