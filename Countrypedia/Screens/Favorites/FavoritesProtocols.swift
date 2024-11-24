//
//  FavoritesProtocols.swift
//  Countrypedia
//
//  Created by Mahmut Doğan on 13.07.2024.
//

import UIKit

// MARK: Favorites Presenter to View Protocol

protocol FavoritesPresenterToViewProtocol: AnyObject {
    var presenter: FavoritesViewToPresenterProtocol? { get set }
    func reloadData()
}

// MARK: Favorites View to Presenter Protocol

protocol FavoritesViewToPresenterProtocol: AnyObject {
    var view: FavoritesPresenterToViewProtocol { get set }
    var interactor: FavoritesPresenterToInteractorProtocol { get set }
    var router: FavoritesPresenterToRouterProtocol { get set }
    
    func fetchFavorites()
    func toggleFavorite(indexPath: IndexPath)
    func numberOfItems() -> Int
    func getItem(indexPath: IndexPath) -> FavoriteCountry
}

// MARK: Favorites Presenter to Interactor Protocol

protocol FavoritesPresenterToInteractorProtocol: AnyObject {
    var presenter: FavoritesInteractorToPresenterProtocol? { get set }
    
    func fetchFavorites()
    func toggleFavorite(country: FavoriteCountry)
}

// MARK: Favorites Interactor to Presenter Protocol

protocol FavoritesInteractorToPresenterProtocol: AnyObject {
    func favoritesFetched(favorites: [FavoriteCountry])
    func favoriteRemoved()
}

// MARK: Favorites Presenter to Router Protocol

protocol FavoritesPresenterToRouterProtocol: AnyObject {
    var viewController: UIViewController? { get set }
    static func createModule() -> UIViewController
}
