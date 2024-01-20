//
//  DetailsPresenter.swift
//  Countries
//
//  Created by Mahmut Gazi Doğan on 19.01.2024.
//

import Foundation

class DetailsPresenter: DetailsViewToPresenterProtocol {
    
    var view: DetailsPresenterToViewProtocol?
    var interactor: DetailsPresenterToInteractorProtocol?
    var router: DetailsPresenterToRouterProtocol?
    
    func getCountryDetails(countryDetails: Country?) {
        interactor?.getCountryDetails(countryDetails: countryDetails)
    }
    
    func getDetails() -> Country? {
        return interactor?.giveDetails()
    }
    
    func numberFormatter(number: Double) -> String? {
        interactor?.numberFormatter(number: number)
    }
}

extension DetailsPresenter: DetailsInteractorToPresenterProtocol {
    
}
