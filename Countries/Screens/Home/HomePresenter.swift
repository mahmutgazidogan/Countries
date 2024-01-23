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
    
    // TODO: Recursive fonksiyonlarla data taşıma
    
    func getFilteredByContinents() -> [Country]? {
        return interactor?.filterByContinents()
    }
    
    func getCountOfFilteredByContinents() -> Int? {
        return interactor?.countOfFilteredByContinents()
    }
    
    func getFilteredCountries(searchText: String) {
        interactor?.filteredCountries(searchText: searchText)
    }
    
    
    
    func changeContinent(continent: Continent) {
        interactor?.changeContinent(continent: continent)
    }
    
//    func getfilterCountriesFor(searchText: String) -> [Country]? {
//        return interactor?.filterCountriesFor(searchText: searchText)
//    }
    
    func getCountOfFilteredCountries() -> Int? {
        return interactor?.countOfFilteredCountries()
    }
    
    // MARK: - Presenter to Router - Navigation
    
    func didSelectItemAt(country: Country?) {
        guard let country else { return }
            router?.navigateToDetails(selectedCountryDetails: country)
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
