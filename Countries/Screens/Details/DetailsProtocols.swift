//
//  DetailsProtocols.swift
//  Countries
//
//  Created by Mahmut Gazi Doğan on 19.01.2024.
//

import Foundation
import UIKit

protocol DetailsPresenterToViewProtocol: AnyObject {
    var presenter: DetailsViewToPresenterProtocol? { get set }
    
    func showDetails()
}

protocol DetailsViewToPresenterProtocol: AnyObject {
    var view: DetailsPresenterToViewProtocol? { get set }
    var interactor: DetailsPresenterToInteractorProtocol? { get set }
    var router: DetailsPresenterToRouterProtocol? { get set }
    
    func getDetails() -> Country?
    func numberFormatter(number: Double) -> String?
    func getCurrency() -> String?
}

protocol DetailsPresenterToInteractorProtocol: AnyObject {
    var presenter: DetailsInteractorToPresenterProtocol? { get set }
    var details: Country? { get set }
    
    func giveDetails() -> Country?
    func numberFormatter(number: Double) -> String?
    func giveCurrency() -> String?
}

protocol DetailsInteractorToPresenterProtocol: AnyObject {
    
}

protocol DetailsPresenterToRouterProtocol: AnyObject {
    static func createModule(selectedCountryDetails details: Country?) -> DetailsViewController
}
