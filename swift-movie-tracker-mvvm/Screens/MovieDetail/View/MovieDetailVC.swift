//
//  MovieDetailVC.swift
//  swift-movie-tracker-mvvm
//
//  Created by Mursel Elibol on 11.05.2023.
//

import UIKit

protocol MovieDetailViewInterface: AnyObject {
    var movieId: Int { get }
}

class MovieDetailVC: UIViewController {
    var movieId: Int
    private lazy var viewModel = MovieDetailVM()
    
    
    init(id: Int) {
        self.movieId = id
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.view = self
        viewModel.viewDidLoad()
    }
}


extension MovieDetailVC: MovieDetailViewInterface {

}
