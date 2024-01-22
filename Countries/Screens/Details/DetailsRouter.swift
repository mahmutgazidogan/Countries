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
        let presenter: DetailsInteractorToPresenterProtocol & DetailsViewToPresenterProtocol = DetailsPresenter()
        let router: DetailsPresenterToRouterProtocol = DetailsRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        interactor.details = details
        
        return view
    }
    
}
