//
//  TabBarController.swift
//  Countrypedia
//
//  Created by Mahmut Doğan on 12.07.2024.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }
    
    private func setupViews() {
//        navigationController?.isNavigationBarHidden = false
        tabBar.backgroundColor = AppColor.mainBackground.color
        tabBar.tintColor = AppColor.title.color
        
        let homeViewController = HomeRouter.createModule()
        homeViewController.tabBarItem = UITabBarItem(title: homeViewController.title, 
                                                     image: UIImage(systemName: "globe"),
                                                     tag: 0)
        
        let favoritesViewController = FavoritesRouter.createModule()
        favoritesViewController.tabBarItem = UITabBarItem(title: "Favorites", 
                                                          image: UIImage(systemName: "heart.fill"),
                                                          tag: 1)
        
        viewControllers = [homeViewController, favoritesViewController]
    }

}
