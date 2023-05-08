//
//  UIImage+Ext.swift
//  swift-movie-tracker-mvvm
//
//  Created by Mursel Elibol on 8.05.2023.
//

import UIKit

extension UIImage {
    func resize(to size: CGSize) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { _ in
            draw(in: CGRect(origin: .zero, size: size))
        }
    }
}
