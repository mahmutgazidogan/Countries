//
//  HomePresenter.swift
//  Countries
//
//  Created by Mahmut Gazi Doğan on 4.11.2023.
//

import UIKit

final class HomePresenter: HomeViewToPresenterProtocol {

    var view: HomePresenterToViewProtocol
    var interactor: HomePresenterToInteractorProtocol
    var router: HomePresenterToRouterProtocol
    
    init(view: HomePresenterToViewProtocol,
         interactor: HomePresenterToInteractorProtocol,
         router: HomePresenterToRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    func updateUI() {
        interactor.fetchAllCountries()
    }
    
    func getTitleForSegmentedControl(segmented: UISegmentedControl) {
        interactor.titleForSegmentedControl(segmented: segmented)
    }
    
    // TODO: Recursive fonksiyonlarla data taşıma
    
    func getFilteredByContinents() -> [Country]? {
        return interactor.filterByContinents()
    }
    
    func getCountOfFilteredByContinents() -> Int? {
        return interactor.countOfFilteredByContinents()
    }
    
    func getSearchedCountries(searchText: String) {
        interactor.searchedCountries(searchText: searchText)
    }
    
    func changeContinent(segmented: UISegmentedControl) {
        interactor.changeContinent(segmented: segmented)
    }
    
    func getCountOfSearchedCountries() -> Int? {
        return interactor.countOfSearchedCountries()
    }
    
    // MARK: - Presenter to Router - Navigation
    
    func didSelectItemAt(country: Country?) {
        guard let country else { return }
            router.navigateToDetails(selectedCountryDetails: country)
    }
}

// MARK: Interactor to Presenter

extension HomePresenter: HomeInteractorToPresenterProtocol {
    func reloadData() {
        view.reloadData()
    }
    
    func showLoadingIndicator() {
        view.showLoadingIndicator()
    }
    
    func hideLoadingIndicator() {
        view.hideLoadingIndicator()
    }
    
    func showAlert(title: String, message: String) {
        view.showAlert(title: title, message: message)
    }
}
