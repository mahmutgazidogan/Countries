//
//  HomeRouter.swift
//  Countries
//
//  Created by Mahmut Gazi Doğan on 4.11.2023.
//

import Foundation
import UIKit

class HomeRouter: HomePresenterToRouterProtocol {
    
    weak var viewController: UIViewController?
    
    static func createModule() -> UIViewController {
        
        let view = HomeViewController()
        let interactor: HomePresenterToInteractorProtocol = HomeInteractor()
        let presenter: HomeInteractorToPresenterProtocol & HomeViewToPresenterProtocol = HomePresenter()
        let router: HomePresenterToRouterProtocol = HomeRouter()
        
        let navigation = UINavigationController(rootViewController: view)
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        router.viewController = view
        
        return navigation
    }
    
    func navigateToDetails(selectedCountryDetails details: Country?) {
        let detailsViewController = DetailsRouter.createModule()
        viewController?.navigationController?.pushViewController(detailsViewController, animated: true)
        guard let presenter = detailsViewController.presenter else { return }
        presenter.getCountryDetails(countryDetails: details)
    }
    
}
