//
//  FavoritesRouter.swift
//  Countrypedia
//
//  Created by Mahmut Doğan on 13.07.2024.
//

import UIKit

final class FavoritesRouter: FavoritesPresenterToRouterProtocol {
    weak var viewController: UIViewController?
    
    // MARK: Creating ViewController Function
    
    static func createModule() -> UIViewController {
        let view = FavoritesViewController()
        let interactor: FavoritesPresenterToInteractorProtocol = FavoritesInteractor()
        let router: FavoritesPresenterToRouterProtocol = FavoritesRouter()
        let presenter: FavoritesViewToPresenterProtocol & FavoritesInteractorToPresenterProtocol = FavoritesPresenter(view: view,
                                                                                                                      interactor: interactor,
                                                                                                                      router: router)
        let navigation = UINavigationController(rootViewController: view)
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        return navigation
    }
    
}
