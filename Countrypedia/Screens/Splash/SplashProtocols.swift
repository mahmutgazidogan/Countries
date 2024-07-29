//
//  SplashProtocols.swift
//  Countries
//
//  Created by Mahmut Doğan on 13.06.2024.
//

import UIKit

// MARK: Splash View Protocol

protocol ViewProtocol: AnyObject {
    func animationStarting()
    func goToHome()
}

// MARK: Splash View to Presenter Protocol

protocol SplashViewToPresenterProtocol: AnyObject {
    var view: ViewProtocol? { get set }
    var router: PresenterToRouterProtocol? { get set }
    func showHomeScreen()
}

// MARK: Splash Presenter to Router Protocol

protocol PresenterToRouterProtocol: AnyObject {
    static func createModule() -> UIViewController
    func navigateToTabBar(from view: ViewProtocol?)
}
