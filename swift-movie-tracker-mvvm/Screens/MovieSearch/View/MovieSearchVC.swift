//
//  MovieSearchVC.swift
//  swift-movie-tracker-mvvm
//
//  Created by Mursel Elibol on 27.05.2023.
//

import UIKit

protocol MovieSearchViewInterface: AnyObject {
    
    
}

final class MovieSearchVC: UIViewController {
    
    private lazy var viewModel = MovieSearchVM()

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.view = self
        viewModel.viewDidLoad()
    }

}

extension MovieSearchVC: MovieSearchViewInterface {
    
}
