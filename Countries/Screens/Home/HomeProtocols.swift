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
    
    func showCountries()
    func startAnimating()
    func stopAnimating()
}

protocol HomeViewToPresenterProtocol: AnyObject {
    var view: HomePresenterToViewProtocol? { get set }
    var interactor: HomePresenterToInteractorProtocol? { get set }
    var router: HomePresenterToRouterProtocol? { get set }
    
    func updateUI()
    func getTitleForSegmentedControl(segmented: UISegmentedControl)
    func getFilteredByContinents() -> [Country]?
    func getCountOfFilteredByContinents() -> Int?
    func getFilteredCountries(searchText: String)
    func getCountOfFilteredCountries() -> Int?
    func changeContinent(continent: Continent)
    func didSelectItemAt(country: Country?)
    
//    func getfilterCountriesFor(searchText: String) -> [Country]?
}

protocol HomePresenterToInteractorProtocol: AnyObject {
    var presenter: HomeInteractorToPresenterProtocol? { get set }
    var countryList: Countries? { get set }
    var selectedContinent: Continent? { get set }
    var filteredCountries: Countries? { get set }
        
    func fetchAllCountries()
    func titleForSegmentedControl(segmented: UISegmentedControl)
    func filterByContinents() -> [Country]?
    func countOfFilteredByContinents() -> Int?
    func filteredCountries(searchText: String)
    func countOfFilteredCountries() -> Int?
    
    func changeContinent(continent: Continent)
    
//    func filterCountriesFor(searchText: String) -> [Country]?
}

protocol HomeInteractorToPresenterProtocol: AnyObject {    
    func successfullyFetched()
    func startAnimating()
    func stopAnimating()
}

protocol HomePresenterToRouterProtocol: AnyObject {
    var viewController: UIViewController? { get set }
    
    static func createModule() -> UIViewController
    func navigateToDetails(selectedCountryDetails details: Country?)
}
