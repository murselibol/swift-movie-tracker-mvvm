//
//  Colors.swift
//  swift-movie-tracker-mvvm
//
//  Created by Mursel Elibol on 12.06.2023.
//

import UIKit

enum ColorName: String {
    case bgColor = "bgColor"
    case defaultColor = "defaultColor"
    case primaryColor = "primaryColor"
    case secondaryColor = "secondaryColor"
    case starColor = "starColor"
    case textGrayColor = "textGrayColor"
    case titleColor = "titleColor"
}

extension UIColor {
    static func getColor(color: ColorName) -> CGColor? {
        return UIColor(named: color.rawValue)?.cgColor
    }
}
