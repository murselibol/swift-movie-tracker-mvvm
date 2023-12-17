//
//  UITraitCollection+Ext.swift
//  swift-movie-tracker-mvvm
//
//  Created by Mursel Elibol on 17.12.2023.
//

import UIKit

extension UITraitCollection {
    static var currentThemeMode: UIUserInterfaceStyle {
        get {
            return UITraitCollection.current.userInterfaceStyle
        }
        set {
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let window = windowScene.windows.first {
                window.overrideUserInterfaceStyle = newValue
            }
        }
    }
}

