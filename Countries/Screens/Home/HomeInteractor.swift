//
//  HomeInteractor.swift
//  Countries
//
//  Created by Mahmut Gazi Doğan on 4.11.2023.
//

import Foundation

class HomeInteractor: HomePresenterToInteractorProtocol {
    
    var presenter: HomeInteractorToPresenterProtocol? //= HomePresenter()
    var countryList: Countries? = [] 
    
    func fetchAllCountries() {
        NetworkingManager.shared.routerRequest(request: Router.allCountries) { (result: Result<Countries, Error>) in
            switch result {
            case .success(let data):
                self.countryList = data
                self.presenter?.successfullyFetched()
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
    
}
