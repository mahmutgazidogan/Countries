//
//  FavoritesInteractor.swift
//  Countrypedia
//
//  Created by Mahmut Doğan on 13.07.2024.
//

import Foundation

final class FavoritesInteractor: FavoritesPresenterToInteractorProtocol {
    var presenter: FavoritesInteractorToPresenterProtocol?
    
    // MARK: Fetching & Toggle Functions
    
    func fetchFavorites() {
        let favorites = CoreDataManager.shared.getAllFavorites()
        presenter?.favoritesFetched(favorites: favorites)
    }
    
    func toggleFavorite(country: FavoriteCountry) {
        CoreDataManager.shared.removeFromFavorites(name: country.name ?? AppConstants.emptyString.text)
        NotificationCenter.default.post(name: NSNotification.Name("FavoriteStatusChanged"),
                                        object: nil)
        NotificationCenter.default.post(name: NSNotification.Name("UpdateFavoriteBadge"),
                                        object: nil)
        presenter?.favoriteRemoved()
    }
    
}
