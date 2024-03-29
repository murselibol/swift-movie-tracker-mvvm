//
//  MovieSearchVC.swift
//  swift-movie-tracker-mvvm
//
//  Created by Mursel Elibol on 27.05.2023.
//

import UIKit

enum SearchVisibleItem {
    case placeholder, table
}

protocol MovieSearchViewInterface: AnyObject {
    var searchText: String { get }
    
    func startLoadingIndicator()
    func stopLoadingIndicator()
    
    func configureVC()
    func configureSearchTextField()
    func configureMoviesTableView()
    
    func becomeFirstResponder()
    func moviesTableReloadData()
    func updatePlaceholder(text: String)
    
    func hiddenMoviesTable(state: Bool)
    func hiddenPlaceholderTextView(state: Bool)
    
    func navigateController(vc: UIViewController, animate: Bool)
    
}

final class MovieSearchVC: UIViewController {
    
    @IBOutlet private weak var searchTextField: UITextField!
    @IBOutlet private weak var moviesTableView: UITableView!
    @IBOutlet private weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var placeholderTextView: PlaceholderTextView!
    
    private lazy var viewModel = MovieSearchVM(view: self)

    override func viewDidLoad() {
        super.viewDidLoad()

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
        searchTextField.addIconToRight(image: UIImage(systemName: "magnifyingglass")!)
    }
    
    func configureMoviesTableView() {
        moviesTableView.delegate = self
        moviesTableView.dataSource = self
        moviesTableView.registerCell(type: MovieTableCell.self)
    }
    
    func becomeFirstResponder() {
        guard searchText.count < 3 else { return }
        searchTextField.becomeFirstResponder()
    }
    
    func moviesTableReloadData() {
        moviesTableView.reloadData()
    }

    func updatePlaceholder(text: String) {
        placeholderTextView.setup(text: text)
    }
   
    
    func hiddenMoviesTable(state: Bool) {
        moviesTableView.isHidden = state
    }
    
    func hiddenPlaceholderTextView(state: Bool) {
        placeholderTextView.isHidden = state
    }
    
    func navigateController(vc: UIViewController, animate: Bool) {
        self.navigationController?.pushViewController(vc, animated: animate)
    }
}

//MARK: - UITextViewDelegate
extension MovieSearchVC: UITextViewDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
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


