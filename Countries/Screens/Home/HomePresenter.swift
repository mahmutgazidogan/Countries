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
    
    func getFilteredByContinents() -> [Country]? {
        return interactor?.filterByContinents()
    }
    
    func getCountOfFilteredByContinents() -> Int? {
        return interactor?.countOfFilteredByContinents()
    }
    
    func getFilteredCountries(searchText: String) {
        interactor?.filteredCountries(searchText: searchText)
    }
    
    func getCountOfFilteredCountries() -> Int? {
        return interactor?.countOfFilteredCountries()
    }
    
    func changeContinent(continent: Continent) {
        interactor?.changeContinent(continent: continent)
    }
}

extension HomePresenter: HomeInteractorToPresenterProtocol {
    func successfullyFetched() {
        view?.showCountries()
    }
    
    func startAnimating() {
        view?.startAnimating()
    }
    
    func stopAnimating() {
        view?.stopAnimating()
    }
}
