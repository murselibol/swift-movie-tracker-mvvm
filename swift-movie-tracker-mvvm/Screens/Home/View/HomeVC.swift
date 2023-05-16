//
//  HomeVC.swift
//  swift-movie-tracker-mvvm
//
//  Created by Mursel Elibol on 4.05.2023.
//

import UIKit

protocol HomeViewInterface: AnyObject {
    func configureVC()
    func configureNavigationBar()
    func filterButtonPressed()
    
    func configureCollectionView()
    func collectionPagingEnabled()
    func collectionPagingDisabled()
    func collectionScrollToItem(at indexPath: IndexPath)
    func collectionReloadData()
    
    func configureTableView()
    func tableReloadData()
    func updateMoviesTableTitle(title: String)
    
    func navigateToDetailScreen(vc: UIViewController)
}

final class HomeVC: UIViewController {
    @IBOutlet private weak var highlightCollectionView: UICollectionView!
    @IBOutlet private weak var moviesTableView: UITableView!
    @IBOutlet weak var moviesTableTitle: UILabel!
    
    private lazy var viewModel = HomeVM()
    private let highlightCollectionIdentifier = "highlightCollectionView"
    
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.view = self
        viewModel.viewDidLoad()
    }
}

//MARK: - HomeViewInterface
extension HomeVC: HomeViewInterface {
    func configureVC() {
        self.title = "Moowift"
    }
    
    func configureNavigationBar() {
        if let filterImage = UIImage(named: "icon-filter") {
            let resizedImage = filterImage.resize(to: CGSize(width: 22, height: 22))
            let filterBarButton = UIBarButtonItem(image: resizedImage, style: .plain, target: self, action: #selector(filterButtonPressed))
            filterBarButton.tintColor = .label
            navigationItem.rightBarButtonItems = [filterBarButton]
        }
    }
    
    @objc func filterButtonPressed() {
        let filterSheet = viewModel.createFilterSheet()
        navigationController?.present(filterSheet, animated: true, completion: nil)
    }
    
    func navigateToDetailScreen(vc: UIViewController) {
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK: - Highlight Collection
    func configureCollectionView() {
        highlightCollectionView.accessibilityIdentifier = highlightCollectionIdentifier
        highlightCollectionView.delegate = self
        highlightCollectionView.dataSource = self
        highlightCollectionView.registerCell(type: HighlightCollectionCell.self)
        highlightCollectionView.layer.cornerRadius = 8
    }
    
    func collectionPagingEnabled() {
        highlightCollectionView.isPagingEnabled = true
    }
    
    func collectionPagingDisabled() {
        highlightCollectionView.isPagingEnabled = false
    }
    
    func collectionScrollToItem(at indexPath: IndexPath) {
        highlightCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    func collectionReloadData() {
        highlightCollectionView.reloadData()
    }
    
    
    //MARK: - Movies Table
    func configureTableView() {
        moviesTableView.delegate = self
        moviesTableView.dataSource = self
        moviesTableView.registerCell(type: MovieTableCell.self)
    }
    
    func updateMoviesTableTitle(title: String) {
        moviesTableTitle.text = title
    }
    
    func tableReloadData() {
        moviesTableView.reloadData()
    }
    
}

//MARK: - UICollectionView
extension HomeVC: UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.trendingMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: HighlightCollectionCell = highlightCollectionView.dequeueCell(for: indexPath)
        cell.setup(movie: viewModel.trendingMovies[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.frame.size
        return CGSize(width: size.width, height: size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelectItem(at: indexPath, cellType: .highlight)
    }
    
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if scrollView.accessibilityIdentifier == highlightCollectionIdentifier {
            self.viewModel.timer.invalidate()
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView.accessibilityIdentifier == highlightCollectionIdentifier {
            self.viewModel.startCollectionTimer()
            let offSet = scrollView.contentOffset.x
            let width = scrollView.frame.width
            let horizontalCenter = width / 2
            let newIndex = Int(offSet + horizontalCenter) / Int(width)
            viewModel.pageControlIndex = newIndex
        }
    }
}


//MARK: - UITableView
extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.selectedCategoryMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MovieTableCell = moviesTableView.dequeueCell(for: indexPath)
        let movie: Movie = viewModel.selectedCategoryMovies[indexPath.row]
        cell.setup(movie: movie)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        220 // Cell Image Height: 200 (+20 space)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectItem(at: indexPath, cellType: .category)
    }
}
