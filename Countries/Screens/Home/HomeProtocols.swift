//
//  Protocols.swift
//  Countries
//
//  Created by Mahmut Gazi Doğan on 4.11.2023.
//

import Foundation
import UIKit

protocol HomePresenterToViewProtocol: AnyObject {
    var presenter: HomeViewToPresenterProtocol? { get set }
    
    func reloadData()
    func showLoadingIndicator()
    func hideLoadingIndicator()
    func showAlert(title: String, message: String)
}

protocol HomeViewToPresenterProtocol: AnyObject {
    var view: HomePresenterToViewProtocol { get set }
    var interactor: HomePresenterToInteractorProtocol { get set }
    var router: HomePresenterToRouterProtocol { get set }
    
    func updateUI()
    func getTitleForSegmentedControl(segmented: UISegmentedControl)
    func getFilteredByContinents() -> [Country]?
    func getCountOfFilteredByContinents() -> Int?
    func getSearchedCountries(searchText: String)
    func getCountOfSearchedCountries() -> Int?
    func changeContinent(segmented: UISegmentedControl)
//    func didSelectItemAt(country: Country?)
    
    func getNumberOfItems(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int,
                        searchController: UISearchController) -> Int
    
    func getCell(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath,
                        searchController: UISearchController) -> UICollectionViewCell
    
    func getSelectedItem(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath,
                        searchController: UISearchController)
}

protocol HomePresenterToInteractorProtocol: AnyObject {
    var presenter: HomeInteractorToPresenterProtocol? { get set }
    var countryList: Countries? { get set }
    var selectedContinent: Continent? { get set }
    var searchedCountries: Countries? { get set }
        
    func fetchAllCountries()
    func titleForSegmentedControl(segmented: UISegmentedControl)
    func filterByContinents() -> [Country]?
    func countOfFilteredByContinents() -> Int?
    func searchedCountries(searchText: String)
    func countOfSearchedCountries() -> Int?
    func changeContinent(segmented: UISegmentedControl)
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int,
                        searchController: UISearchController) -> Int
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath,
                        searchController: UISearchController) -> UICollectionViewCell
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath,
                        searchController: UISearchController)
}

protocol HomeInteractorToPresenterProtocol: AnyObject {    
    func reloadData()
    func showLoadingIndicator()
    func hideLoadingIndicator()
    func showAlert(title: String, message: String)
    
    func didSelectItemAt(country: Country?)
}

protocol HomePresenterToRouterProtocol: AnyObject {
    var viewController: UIViewController? { get set }
    
    static func createModule() -> UIViewController
    func navigateToDetails(selectedCountryDetails details: Country?)
}
