//
//  DetailsRouter.swift
//  Countries
//
//  Created by Mahmut Gazi Doğan on 19.01.2024.
//

import Foundation

class DetailsRouter: DetailsPresenterToRouterProtocol {
    static func createModule(selectedCountryDetails details: Country?) -> DetailsViewController {
        let view = DetailsViewController()
        let interactor: DetailsPresenterToInteractorProtocol = DetailsInteractor()
        let router: DetailsPresenterToRouterProtocol = DetailsRouter()
        let presenter: DetailsInteractorToPresenterProtocol & DetailsViewToPresenterProtocol = DetailsPresenter(view: view,
                                                                                                                interactor: interactor,
                                                                                                                router: router)
        view.presenter = presenter        
        interactor.presenter = presenter
        interactor.details = details
        return view
    }
}
