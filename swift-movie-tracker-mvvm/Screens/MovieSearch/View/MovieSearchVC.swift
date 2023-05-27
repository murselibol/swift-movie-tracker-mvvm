//
//  MovieSearchVC.swift
//  swift-movie-tracker-mvvm
//
//  Created by Mursel Elibol on 27.05.2023.
//

import UIKit

protocol MovieSearchViewInterface: AnyObject {
    func configureMoviesTableView()
    
}

final class MovieSearchVC: UIViewController {
    
    @IBOutlet weak var searchText: UITextField!
    @IBOutlet weak var moviesTableView: UITableView!
    
    private lazy var viewModel = MovieSearchVM()

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.view = self
        viewModel.viewDidLoad()
    }

}

extension MovieSearchVC: MovieSearchViewInterface {
    func configureMoviesTableView() {
        moviesTableView.delegate = self
        moviesTableView.dataSource = self
        moviesTableView.registerCell(type: MovieTableCell.self)
        moviesTableView.layer.cornerRadius = 8
    }
}

//MARK: - UITableView
extension MovieSearchVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MovieTableCell = moviesTableView.dequeueCell(for: indexPath)
        let movie: Movie = viewModel.movies[indexPath.row]
        cell.setup(movie: movie)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        220 // Cell Image Height: 200 (+20 space)
    }
}
