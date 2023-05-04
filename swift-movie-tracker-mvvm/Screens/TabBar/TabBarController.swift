//
//  TabBarController.swift
//  swift-movie-tracker-mvvm
//
//  Created by Mursel Elibol on 4.05.2023.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
    }
    
    func configure(){
        createTabbar()
    }
    
    func createTabbar(){
        UITabBar.appearance().tintColor = .label
        setViewControllers([
            createNavigationController(vc: HomeVC(), title: "Home", imageName: "house")
            ], animated: true)
    }
    
    func createNavigationController(vc: UIViewController, title: String, imageName: String) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: vc)
        navigationController.title = title
        navigationController.tabBarItem.image = UIImage(systemName: imageName)
        return navigationController
    }
    

}
