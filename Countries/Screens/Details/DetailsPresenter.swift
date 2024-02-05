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
    func getDetails(name: String, capital: String, area: String,
                    population: String, startOfWeek: String,
                    currency: String, timezones: String,
                    flag: String, flagDescription: String,
                    languages: String, carDetails: String,
                    independency: UIImage?) {
        view.showDetails(name: name, capital: capital, area: area,
                         population: population, startOfWeek: startOfWeek,
                         currency: currency, timezones: timezones,
                         flag: flag, flagDescription: flagDescription,
                         languages: languages, carDetails: carDetails,
                         independency: independency)
    }
}
