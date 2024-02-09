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
    
    func showDetails(name: String, capital: String, area: String,
                     population: String, startOfWeek: String,
                     currency: String, timezones: String,
                     flag: String, flagDescription: String,
                     languages: String, sign: String, side: String,
                     independency: String, latitude: Double, longitude: Double)
}

protocol DetailsViewToPresenterProtocol: AnyObject {
    var view: DetailsPresenterToViewProtocol { get set }
    var interactor: DetailsPresenterToInteractorProtocol { get set }
    var router: DetailsPresenterToRouterProtocol { get set }
    
    func updateUI()
}

protocol DetailsPresenterToInteractorProtocol: AnyObject {
    var presenter: DetailsInteractorToPresenterProtocol? { get set }
    var details: Country? { get set }
    
    func giveDetails()
}

protocol DetailsInteractorToPresenterProtocol: AnyObject {
    func getDetails(name: String, capital: String, area: String,
                    population: String, startOfWeek: String,
                    currency: String, timezones: String,
                    flag: String, flagDescription: String,
                    languages: String, sign: String, side: String,
                    independency: String, latitude: Double, longitude: Double)
}

protocol DetailsPresenterToRouterProtocol: AnyObject {
    static func createModule(selectedCountryDetails details: Country?) -> DetailsViewController
}
