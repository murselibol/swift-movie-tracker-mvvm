//
//  HomeVC.swift
//  swift-movie-tracker-mvvm
//
//  Created by Mursel Elibol on 4.05.2023.
//

import UIKit

protocol HomeViewInterface {
    func configureCollectionView()
}

final class HomeVC: UIViewController {
    @IBOutlet weak var highlightCollectionView: UICollectionView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        configureCollectionView()
        
    }


}


extension HomeVC: HomeViewInterface {
    func configureCollectionView() {
        highlightCollectionView.delegate = self
        highlightCollectionView.dataSource = self
        highlightCollectionView.registerCell(type: HighlightCollectionCell.self)
        
    }
    
    
}

//MARK: - UICollectionView
extension HomeVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: HighlightCollectionCell = highlightCollectionView.dequeueCell(for: indexPath)
        cell.setup(title: "Title \(indexPath.row)")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.frame.size
        return CGSize(width: size.width, height: size.height)
    }
    
}
