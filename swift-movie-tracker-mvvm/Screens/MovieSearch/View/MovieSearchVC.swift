//
//  MovieSearchVC.swift
//  swift-movie-tracker-mvvm
//
//  Created by Mursel Elibol on 27.05.2023.
//

import UIKit

protocol MovieSearchViewInterface: AnyObject {
    var searchText: String { get }
    
    func startLoadingIndicator()
    func stopLoadingIndicator()
    
    func configureVC()
    func configureSearchTextField()
    func configureMoviesTableView()
    
    func becomeFirstResponder()
    func moviesTableReloadData()
    
    func navigateController(vc: UIViewController, animate: Bool)
    
}

final class MovieSearchVC: UIViewController {
    
    @IBOutlet private weak var searchTextField: UITextField!
    @IBOutlet private weak var moviesTableView: UITableView!
    @IBOutlet private weak var loadingIndicator: UIActivityIndicatorView!
    
    private lazy var viewModel = MovieSearchVM()

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.view = self
        viewModel.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        viewModel.viewDidAppear()
    }

}

extension MovieSearchVC: MovieSearchViewInterface {
    var searchText: String {
        self.searchTextField.text!
    }
    
    func startLoadingIndicator() {
        loadingIndicator.startAnimating()
    }
    
    func stopLoadingIndicator() {
        loadingIndicator.stopAnimating()
    }
    
    func configureVC() {
        self.title = "Movie Search"
        self.navigationController?.setCustomBackButton()
    }
    
    func configureSearchTextField() {
        searchTextField.delegate = self
    }
    
    func configureMoviesTableView() {
        moviesTableView.delegate = self
        moviesTableView.dataSource = self
        moviesTableView.registerCell(type: MovieTableCell.self)
    }
    
    func becomeFirstResponder() {
        searchTextField.becomeFirstResponder()
    }
    
    func moviesTableReloadData() {
        moviesTableView.reloadData()
    }

    func navigateController(vc: UIViewController, animate: Bool) {
        self.navigationController?.pushViewController(vc, animated: animate)
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectItem(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastRowIndex = tableView.numberOfRows(inSection: 0) - 1

        if indexPath.row == lastRowIndex - 2 {
            viewModel.moviesTableWillDisplay()
        }
    }
}

//MARK: - UITextFieldDelegate
extension MovieSearchVC: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        viewModel.searchTextFieldDidChangeSelection(searchText: searchTextField.text!)
    }
}


