//
//  SplashPresenter.swift
//  Countries
//
//  Created by Mahmut Doğan on 13.06.2024.
//

import Foundation

final class SplashPresenter: SplashViewToPresenterProtocol {
    weak var view: ViewProtocol?
    var router: PresenterToRouterProtocol?
    
    // MARK: Splash View to Presenter Function
    
    func showHomeScreen() {
        router?.navigateToTabBar(from: view)
    }
}

