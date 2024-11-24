//
//  FavoritesPresenter.swift
//  Countrypedia
//
//  Created by Mahmut Doğan on 13.07.2024.
//

import Foundation

final class FavoritesPresenter: FavoritesViewToPresenterProtocol {
    var view: FavoritesPresenterToViewProtocol
    var interactor: FavoritesPresenterToInteractorProtocol
    var router: FavoritesPresenterToRouterProtocol
    private var favorites: [FavoriteCountry] = []
    
    init(view: FavoritesPresenterToViewProtocol, 
         interactor: FavoritesPresenterToInteractorProtocol,
         router: FavoritesPresenterToRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    // MARK: Fetching & View to Presenter Functions
    
    func fetchFavorites() {
        interactor.fetchFavorites()
    }
    
    func numberOfItems() -> Int {
        return favorites.count
    }
    
    func getItem(indexPath: IndexPath) -> FavoriteCountry {
        return favorites[indexPath.row]
    }
    
    func toggleFavorite(indexPath: IndexPath) {
        let favorite = favorites[indexPath.row]
        interactor.toggleFavorite(country: favorite)
    }
    
}

// MARK: Favorites Interactor to Presenter Functions

extension FavoritesPresenter: FavoritesInteractorToPresenterProtocol {
    func favoritesFetched(favorites: [FavoriteCountry]) {
        self.favorites = favorites
        view.reloadData()
    }
    
    func favoriteRemoved() {
        interactor.fetchFavorites()
    }
}
