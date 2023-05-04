//
//  UITableView+Ext.swift
//  swift-movie-tracker-mvvm
//
//  Created by Mursel Elibol on 4.05.2023.
//

import UIKit

extension UITableView {
    func registerCell<T: NibProtocol & ReuseProtocol>(type: T.Type) {
        register(type.nib, forCellReuseIdentifier: type.reuseIdentifier)
    }

    func dequeueCell<T: ReuseProtocol>(for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withIdentifier: T.reuseIdentifier) as! T
    }
}

