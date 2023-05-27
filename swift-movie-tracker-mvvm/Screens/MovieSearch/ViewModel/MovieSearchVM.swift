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
}

extension MovieSearchVM: MovieSearchViewModelInterface {
    func viewDidLoad() {
        print("viewDidLoad")
    }
    
}
