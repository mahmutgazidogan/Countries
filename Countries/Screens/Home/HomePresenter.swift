//
//  HomePresenter.swift
//  Countries
//
//  Created by Mahmut Gazi Doğan on 4.11.2023.
//

import Foundation

class HomePresenter: HomeViewToPresenterProtocol {
    
    var view: HomePresenterToViewProtocol?
    var interactor: HomePresenterToInteractorProtocol?
    var router: HomePresenterToRouterProtocol?
    
    func updateUI() {
        interactor?.fetchAllCountries()
    }
    
    func getAllCountries() -> [Country]? {
        return interactor?.countryList
    }

    func getCountryListCount() -> Int? {
        return interactor?.countryList?.count
    }
    
}

extension HomePresenter: HomeInteractorToPresenterProtocol {
    func successfullyFetched() {
        view?.showCountries()
    }
}
