//
//  MovieDetailVC.swift
//  swift-movie-tracker-mvvm
//
//  Created by Mursel Elibol on 11.05.2023.
//

import UIKit

protocol MovieDetailViewInterface {
    var movieId: Int { get set }
}

class MovieDetailVC: UIViewController {
    var movieID: Int
    
    
    init(id: Int) {
        self.movieID = id
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}


extension MovieDetailVC: MovieDetailViewModelInterface {

}
