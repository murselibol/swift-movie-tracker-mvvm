//
//  UITextField+Ext.swift
//  swift-movie-tracker-mvvm
//
//  Created by Mursel Elibol on 29.05.2023.
//

import UIKit

extension UITextField {
    func addIconToRight(image: UIImage, size: CGSize = CGSize(width: 20,height: 20)) {
        let spacing: CGFloat = 10.0
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: size.width + spacing, height: size.height))

        let iconView = UIImageView(image: image)
        iconView.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        iconView.contentMode = .center
        containerView.addSubview(iconView)

        self.rightView = containerView
        self.rightViewMode = .always
    }
}
