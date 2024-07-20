//
//  FavoritesProtocols.swift
//  Countrypedia
//
//  Created by Mahmut Doğan on 13.07.2024.
//

import UIKit

protocol FavoritesPresenterToViewProtocol: AnyObject {
    var presenter: FavoritesViewToPresenterProtocol? { get set }
}

protocol FavoritesViewToPresenterProtocol: AnyObject {
    var view: FavoritesPresenterToViewProtocol { get set }
    var interactor: FavoritesPresenterToInteractorProtocol { get set }
    var router: FavoritesPresenterToRouterProtocol { get set }
}

protocol FavoritesPresenterToInteractorProtocol: AnyObject {
    var presenter: FavoritesInteractorToPresenterProtocol? { get set }
}

protocol FavoritesInteractorToPresenterProtocol: AnyObject {
    
}

protocol FavoritesPresenterToRouterProtocol: AnyObject {
    var viewController: UIViewController? { get set }
    static func createModule() -> UIViewController
}
