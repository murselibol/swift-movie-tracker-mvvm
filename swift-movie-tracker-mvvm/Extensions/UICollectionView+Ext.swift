//
//  UICollectionView+Ext.swift
//  swift-movie-tracker-mvvm
//
//  Created by Mursel Elibol on 4.05.2023.
//

import UIKit

extension UICollectionView {
    func registerCell<T: NibProtocol & ReuseProtocol>(type: T.Type) {
        register(type.nib, forCellWithReuseIdentifier: type.reuseIdentifier)
    }

    func dequeueCell<T: ReuseProtocol>(for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as! T
    }
}


