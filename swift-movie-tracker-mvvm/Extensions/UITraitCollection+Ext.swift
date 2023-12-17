//
//  UITraitCollection+Ext.swift
//  swift-movie-tracker-mvvm
//
//  Created by Mursel Elibol on 17.12.2023.
//

import UIKit

enum ThemeMode {
    case light
    case dark
    
    static var mode: ThemeMode {
        get { 
            UITraitCollection.current.userInterfaceStyle == .dark ? .dark : .light
        }
        
        set {
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let window = windowScene.windows.first {
                window.overrideUserInterfaceStyle = newValue == ThemeMode.dark ? UIUserInterfaceStyle.dark : UIUserInterfaceStyle.light
            }
        }
    }

}

