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
    func getAllCountries() -> [Country]?
    func getCountryListCount() -> Int?
    func getFilteredCountries(searchText: String)
}

protocol HomePresenterToInteractorProtocol: AnyObject {
    var presenter: HomeInteractorToPresenterProtocol? { get set }
    var countryList: Countries? { get }
    var filteredCountries: Countries? { get }
    var isSearching: Bool { get set }
    
    func fetchAllCountries()
    func filteredCountries(searchText: String)
}

protocol HomeInteractorToPresenterProtocol: AnyObject {    
    func successfullyFetched()
    func startAnimating()
    func stopAnimating()
}

protocol HomePresenterToRouterProtocol {
    var viewController: UIViewController? { get set }
    
    static func createModule() -> UIViewController
}
