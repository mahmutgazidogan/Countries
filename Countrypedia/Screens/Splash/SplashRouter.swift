//
//  SplashRouter.swift
//  Countries
//
//  Created by Mahmut Doğan on 13.06.2024.
//

import UIKit

final class SplashRouter: PresenterToRouterProtocol {
    static func createModule() -> UIViewController {
        let viewController = SplashViewController()
        let presenter: SplashViewToPresenterProtocol = SplashPresenter()
        let router: PresenterToRouterProtocol = SplashRouter()
        viewController.presenter = presenter
        presenter.view = viewController
        presenter.router = router
        return viewController
    }
    
    func navigateToHomeScreen(from view: ViewProtocol?) {
//        if let viewController = view as? UIViewController {
//            let homeViewController = HomeRouter.createModule()
//            homeViewController.modalPresentationStyle = .fullScreen
//            homeViewController.modalTransitionStyle = .crossDissolve
//            viewController.present(homeViewController, animated: true)
//        }
        
        if let viewController = view as? UIViewController {
            let tabBar = TabBarController()
            tabBar.modalPresentationStyle = .fullScreen
            tabBar.modalTransitionStyle = .crossDissolve
            viewController.present(tabBar, animated: true)
        }
    }
}
