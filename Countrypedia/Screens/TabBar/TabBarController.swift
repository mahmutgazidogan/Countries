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
    
    // MARK: View Layout & Setup Function
    
    private func setupViews() {
        tabBar.backgroundColor = AppColor.mainBackground.color
        tabBar.tintColor = AppColor.title.color
        let homeViewController = HomeRouter.createModule()
        let favoritesViewController = FavoritesRouter.createModule()
        homeViewController.tabBarItem = UITabBarItem(title: homeViewController.title,
                                                     image: UIImage(systemName: "globe.europe.africa"),
                                                     selectedImage: UIImage(systemName: "globe.europe.africa.fill"))
        favoritesViewController.tabBarItem = UITabBarItem(title: "Favorites",
                                                          image: UIImage(systemName: "heart"),
                                                          selectedImage: UIImage(systemName: "heart.fill"))
        
        viewControllers = [homeViewController, favoritesViewController]
    }

}
