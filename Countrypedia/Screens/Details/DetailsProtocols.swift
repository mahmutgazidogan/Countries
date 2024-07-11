//
//  DetailsProtocols.swift
//  Countries
//
//  Created by Mahmut Gazi Doğan on 19.01.2024.
//

import UIKit

protocol DetailsPresenterToViewProtocol: AnyObject {
    var presenter: DetailsViewToPresenterProtocol? { get set }
    func showDetails(details: Country)
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
    func getDetails(details: Country)
}

protocol DetailsPresenterToRouterProtocol: AnyObject {
    static func createModule(selectedCountryDetails details: Country?) -> DetailsViewController
}
