//
//  DetailsPresenter.swift
//  Countries
//
//  Created by Mahmut Gazi Doğan on 19.01.2024.
//

import Foundation

final class DetailsPresenter: DetailsViewToPresenterProtocol {
    
    var view: DetailsPresenterToViewProtocol
    var interactor: DetailsPresenterToInteractorProtocol
    var router: DetailsPresenterToRouterProtocol
    
    init(view: DetailsPresenterToViewProtocol,
         interactor: DetailsPresenterToInteractorProtocol,
         router: DetailsPresenterToRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    func getDetails() -> Country? {
        return interactor.giveDetails()
    }
    
    func numberFormatter(number: Double) -> String? {
        interactor.numberFormatter(number: number)
    }
    func getCurrency() -> String? {
        return interactor.giveCurrency()
    }
}

extension DetailsPresenter: DetailsInteractorToPresenterProtocol {
    
}
