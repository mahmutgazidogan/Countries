//
//  DetailsProtocols.swift
//  Countries
//
//  Created by Mahmut Gazi Doğan on 19.01.2024.
//

import UIKit

// MARK: Details Presenter to View Protocol

protocol DetailsPresenterToViewProtocol: AnyObject {
    var presenter: DetailsViewToPresenterProtocol? { get set }
    func showDetails(details: Country)
}

// MARK: Details View to Presenter Protocol

protocol DetailsViewToPresenterProtocol: AnyObject {
    var view: DetailsPresenterToViewProtocol { get set }
    var interactor: DetailsPresenterToInteractorProtocol { get set }
    var router: DetailsPresenterToRouterProtocol { get set }
    func updateUI()
}

// MARK: Details Presenter to Interactor Protocol

protocol DetailsPresenterToInteractorProtocol: AnyObject {
    var presenter: DetailsInteractorToPresenterProtocol? { get set }
    var details: Country? { get set }
    func giveDetails()
}

// MARK: Details Interactor to Presenter Protocol

protocol DetailsInteractorToPresenterProtocol: AnyObject {
    func getDetails(details: Country)
}

// MARK: Details Presenter to Router Protocol

protocol DetailsPresenterToRouterProtocol: AnyObject {
    static func createModule(selectedCountryDetails details: Country?) -> DetailsViewController
}
