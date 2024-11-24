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
        setupFavoriteBadge()
        updateFavoriteBadge()
        addNotificationObserver()
    }
    
    deinit {
        removeNotificationObserver()
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
    
    private func setupFavoriteBadge() {
        if let favorites = tabBar.items?[1] {
            favorites.badgeColor = AppColor.title.color
            favorites.setBadgeTextAttributes([NSAttributedString.Key.foregroundColor: AppColor.mainBackground.color],
                                                for: .normal)
        }
    }
    
    private func updateFavoriteBadge() {
        let favoriteCount = CoreDataManager.shared.getFavoriteCount()
        if let favorites = tabBar.items?[1] {
            if favoriteCount > 0 {
                favorites.badgeValue = String(favoriteCount)
            } else {
                favorites.badgeValue = nil
            }
        }
    }
    
    private func addNotificationObserver() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(handleFavoritesChanged),
                                               name: NSNotification.Name("UpdateFavoriteBadge"),
                                               object: nil)
    }
    
    private func removeNotificationObserver() {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc private func handleFavoritesChanged() {
        updateFavoriteBadge()
    }
    
}
