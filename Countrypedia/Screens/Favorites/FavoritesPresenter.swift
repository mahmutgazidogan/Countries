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
    
    init(view: FavoritesPresenterToViewProtocol, 
         interactor: FavoritesPresenterToInteractorProtocol,
         router: FavoritesPresenterToRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
}

// MARK: Favorites Interactor to Presenter Functions

extension FavoritesPresenter: FavoritesInteractorToPresenterProtocol {
    
}
