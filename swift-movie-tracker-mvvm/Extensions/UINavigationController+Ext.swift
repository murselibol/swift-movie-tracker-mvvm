//
//  UINavigationController+Ext.swift
//  swift-movie-tracker-mvvm
//
//  Created by Mursel Elibol on 28.05.2023.
//

import UIKit

extension UINavigationController {
    func setCustomBackButton(imageName: String = "chevron.backward", title: String = "", color: UIColor = .white) {
        let image = UIImage(systemName: imageName)
        
        navigationBar.backIndicatorImage = image
        navigationBar.backIndicatorTransitionMaskImage = image
        navigationBar.tintColor = .white
        navigationBar.topItem?.backButtonTitle = title
    }
}
