//
//  DetailsPresenter.swift
//  Countries
//
//  Created by Mahmut Gazi Doğan on 19.01.2024.
//

import UIKit

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
    
    func updateUI() {
        interactor.giveDetails()
    }
}

extension DetailsPresenter: DetailsInteractorToPresenterProtocol {
    func getDetails(details: Country) {
        view.showDetails(details: details)
    }
}
