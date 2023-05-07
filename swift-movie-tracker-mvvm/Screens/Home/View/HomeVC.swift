//
//  HomeVC.swift
//  swift-movie-tracker-mvvm
//
//  Created by Mursel Elibol on 4.05.2023.
//

import UIKit

protocol HomeViewInterface: AnyObject {
    func configureCollectionView()
    func collectionPagingEnabled()
    func collectionPagingDisabled()
    func collectionScrollToItem(at indexPath: IndexPath)
    func collectionReloadData()
}

final class HomeVC: UIViewController {
    @IBOutlet private weak var highlightCollectionView: UICollectionView!
    private lazy var viewModel = HomeVM()
    
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.view = self
        viewModel.viewDidLoad()
    }
    
}

//MARK: - HomeViewInterface
extension HomeVC: HomeViewInterface {
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
}

//MARK: - UICollectionView
extension HomeVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: HighlightCollectionCell = highlightCollectionView.dequeueCell(for: indexPath)
        cell.setup(movie: viewModel.movies[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.frame.size
        return CGSize(width: size.width, height: size.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let offSet = scrollView.contentOffset.x
        let width = scrollView.frame.width
        let horizontalCenter = width / 2
        let newIndex = Int(offSet + horizontalCenter) / Int(width)
        viewModel.pageControlIndex = newIndex
    }
}
