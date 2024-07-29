//
//  HomeRouter.swift
//  Countries
//
//  Created by Mahmut Gazi Doğan on 4.11.2023.
//

import Foundation
import UIKit

final class HomeRouter: HomePresenterToRouterProtocol {
    weak var viewController: UIViewController?
    
    // MARK: Creating ViewController Function
    
    static func createModule() -> UIViewController {
        let view = HomeViewController()
        let interactor: HomePresenterToInteractorProtocol = HomeInteractor()
        let router: HomePresenterToRouterProtocol = HomeRouter()
        let presenter: HomeInteractorToPresenterProtocol & HomeViewToPresenterProtocol = HomePresenter(view: view,
                                                                                                       interactor: interactor,
                                                                                                       router: router)
        let navigation = UINavigationController(rootViewController: view)
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        return navigation
    }
    
    // MARK: Detail Navigation Function
    
    func navigateToDetails(selectedCountryDetails details: Country?) {
        let detailsViewController = DetailsRouter.createModule(selectedCountryDetails: details)
        detailsViewController.hidesBottomBarWhenPushed = true
        viewController?.navigationController?.pushViewController(detailsViewController, animated: true)
    }
}
