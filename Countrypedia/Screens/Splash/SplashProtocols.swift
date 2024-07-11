//
//  SplashProtocols.swift
//  Countries
//
//  Created by Mahmut Doğan on 13.06.2024.
//

import UIKit

protocol ViewProtocol: AnyObject {
    func animationStarting()
    func goToHome()
}

protocol SplashViewToPresenterProtocol: AnyObject {
    var view: ViewProtocol? { get set }
    var router: PresenterToRouterProtocol? { get set }
    func showHomeScreen()
}

protocol PresenterToRouterProtocol: AnyObject {
    static func createModule() -> UIViewController
    func navigateToHomeScreen(from view: ViewProtocol?)
}
