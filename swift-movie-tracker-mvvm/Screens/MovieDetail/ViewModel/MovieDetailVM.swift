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
    
}

extension MovieDetailVM: MovieDetailViewModelInterface {
    func viewDidLoad() {
        print("DidLoad")
    }
    
    
}
