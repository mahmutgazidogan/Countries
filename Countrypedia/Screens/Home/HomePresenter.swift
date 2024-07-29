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
    
    // MARK: Fetch & Filter Functions
    
    func updateUI() {
        interactor.fetchAllCountries()
    }

    func getSearchedCountries(searchText: String) {
        interactor.searchedCountries(searchText: searchText)
    }
    
    func changeContinent(segmented: UISegmentedControl) {
        interactor.changeContinent(segmented: segmented)
    }
    
    // MARK: Favorite Function
    
    func toggleFavorite(index: Int, searchText: String) {
        if searchText.isEmpty {
            guard let country = interactor.filterByContinents() else { return }
            interactor.toggleFavorite(country: country[index], searchText: searchText)
        } else {
            guard let country = interactor.searchedCountries else { return }
            interactor.toggleFavorite(country: country[index], searchText: searchText)
        }
    }
    
    // MARK: CollectionView Functions
    
    func getNumberOfItems(_ collectionView: UICollectionView,
                          numberOfItemsInSection section: Int,
                          searchController: UISearchController) -> Int {
        return interactor.collectionView(collectionView,
                                         numberOfItemsInSection: section,
                                         searchController: searchController)
    }
    
    func getCell(_ collectionView: UICollectionView,
                 cellForItemAt indexPath: IndexPath,
                 viewController: UIViewController,
                 searchController: UISearchController) -> UICollectionViewCell {
    return interactor.collectionView(collectionView,
                                     cellForItemAt: indexPath,
                                     viewController: viewController,
                                     searchController: searchController)
}

    // MARK: - Presenter to Interactor - Navigation
    
    func getSelectedItem(_ collectionView: UICollectionView,
                         didSelectItemAt indexPath: IndexPath,
                         searchController: UISearchController) {
        interactor.collectionView(collectionView,
                                  didSelectItemAt: indexPath,
                                  searchController: searchController)
    }
}

    // MARK: Interactor to Presenter Functions

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
    
    func showAlert(title: String, message: String, tryAgainHandler: ((UIAlertAction) -> Void)?, exitHandler: ((UIAlertAction) -> Void)?) {
        view.showAlert(title: title, message: message, tryAgainHandler: tryAgainHandler, exitHandler: exitHandler)
    }
    
    // MARK: - Presenter to Router - Navigation
    
    func didSelectItemAt(country: Country?) {
        guard let country else { return }
        router.navigateToDetails(selectedCountryDetails: country)
    }
}
