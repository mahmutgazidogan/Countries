//
//  HomePresenter.swift
//  Countries
//
//  Created by Mahmut Gazi Doğan on 4.11.2023.
//

import Foundation

class HomePresenter: HomeViewToPresenterProtocol {
    var view: HomePresenterToViewProtocol?
    var interactor: HomePresenterToInteractorProtocol? = HomeInteractor()
    
    func updateUI() {
        interactor?.fetchAllCountries()
    }
    
    
}

extension HomePresenter: HomeInteractorToPresenterProtocol { }
