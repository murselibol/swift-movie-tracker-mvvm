//
//  UIImageView+Ext.swift
//  swift-movie-tracker-mvvm
//
//  Created by Mursel Elibol on 7.05.2023.
//

import UIKit
import SDWebImage

extension UIImageView {
    func loadURLWithCdn(url: String) {
        let urlWithCdn = NetworkHelper.shared.getImagePath(url: url)
        if let url = URL(string: urlWithCdn) {
            sd_setImage(with: url)
        }
    }
    func loadURL(url: String) {
        if let url = URL(string: url) {
            sd_setImage(with: url)
        }
    }
}

