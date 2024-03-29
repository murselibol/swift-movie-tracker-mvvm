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
    func changeThemeBarButtonImage(imageName: String)
    
    func configureCollectionView()
    func collectionPagingEnabled()
    func collectionPagingDisabled()
    func collectionScrollToItem(at indexPath: IndexPath)
    func collectionReloadData()
    
    func configureTableView()
    func tableReloadData()
    func updateMoviesTableTitle(title: String)
    
    func navigatePresent(vc: UIViewController, animate: Bool)
    func navigateController(vc: UIViewController, animate: Bool)
}

final class HomeVC: UIViewController {
    @IBOutlet private weak var highlightCollectionView: UICollectionView!
    @IBOutlet private weak var moviesTableView: UITableView!
    @IBOutlet private weak var moviesTableTitle: UILabel!
    @IBOutlet private weak var moviesTableHeightConstraint: NSLayoutConstraint!
    
    private var searchBarButton: UIBarButtonItem!
    private var filterBarButton: UIBarButtonItem!
    private var themeBarButton: UIBarButtonItem!
    
    private lazy var viewModel = HomeVM(view: self)
    
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.viewDidLoad()
    }
}

//MARK: - HomeViewInterface
extension HomeVC: HomeViewInterface {
    func configureVC() {
        self.title = "Moowift"
    }
    
    func configureNavigationBar() {
        let filterImage = UIImage(named: "icon-filter")
        let resizedFilterImage = filterImage?.resize(to: CGSize(width: 22, height: 22))
        filterBarButton = UIBarButtonItem(image: resizedFilterImage, style: .plain, target: self, action: #selector(filterButtonPressed))
        filterBarButton.tintColor = .label
        
        let searchImage = UIImage(systemName: "magnifyingglass")
        let resizedSearchImage = searchImage?.resize(to: CGSize(width: 22, height: 22))
        searchBarButton = UIBarButtonItem(image: resizedSearchImage, style: .plain, target: self, action: #selector(searchButtonPressed))
        searchBarButton.tintColor = .label
        
        let themeImage = UIImage(systemName: ThemeMode.mode == .dark ? "sun.max.fill" : "moon.circle.fill")
        let resizedThemeImage = themeImage?.resize(to: CGSize(width: 22, height: 22))
        themeBarButton = UIBarButtonItem(image: resizedThemeImage, style: .plain, target: self, action: #selector(themeButtonPressed))
        themeBarButton.tintColor = .label
        
        navigationItem.rightBarButtonItems = [filterBarButton, searchBarButton]
        navigationItem.leftBarButtonItems = [themeBarButton]
    }
    
    @objc private func filterButtonPressed() {
        viewModel.openFilterSheet()
    }
    
    @objc private func searchButtonPressed() {
        viewModel.navigateSearchVC()
    }
    
    @objc private func themeButtonPressed() {
        viewModel.changeThemeMode(currentTheme: ThemeMode.mode)
    }
    
    func changeThemeBarButtonImage(imageName: String) {
        themeBarButton.image = UIImage(systemName: imageName)
    }
    
    func navigateController(vc: UIViewController, animate: Bool) {
        self.navigationController?.pushViewController(vc, animated: animate)
    }
    
    func navigatePresent(vc: UIViewController, animate: Bool) {
        navigationController?.present(vc, animated: animate)
    }
    
    //MARK: - Highlight Collection
    func configureCollectionView() {
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
        if scrollView == highlightCollectionView {
            self.viewModel.timer.invalidate()
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == highlightCollectionView {
            self.viewModel.startCollectionTimer()
            let offSet = scrollView.contentOffset.x
            let width = scrollView.frame.width
            let horizontalCenter = width / 2
            let newIndex = Int(offSet + horizontalCenter) / Int(width) + 1
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
        // TODO: Find a better solution
        moviesTableHeightConstraint.constant = moviesTableView.contentSize.height + CGFloat((viewModel.selectedCategoryMovies.count - 1) * 20)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        220 // Cell Image Height: 200 (+20 space)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectItem(at: indexPath, cellType: .category)
    }
}
