//
//  HomeInteractor.swift
//  Countries
//
//  Created by Mahmut Gazi Doğan on 4.11.2023.
//

import Foundation

class HomeInteractor: HomePresenterToInteractorProtocol {
    
    var presenter: HomeInteractorToPresenterProtocol? 
    var countryList: Countries? = []
    var filteredCountries: Countries? = []
    var isSearching: Bool = false
    
    func fetchAllCountries() {
        presenter?.startAnimating()
        NetworkingManager.shared.routerRequest(request: Router.allCountries) { (result: Result<Countries, Error>) in
            switch result {
            case .success(let data):
                self.countryList = data
                self.countryList = self.countryList?.sorted {
                    $0.name?.common?.lowercased() ?? "" < $1.name?.common?.lowercased() ?? ""
                }
                self.presenter?.successfullyFetched()
                self.presenter?.stopAnimating()
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
    
    func filteredCountries(searchText: String) {
        filteredCountries = countryList?.filter({ country in
            country.name?.common?.lowercased().contains(searchText.lowercased()) ?? false
        })
        self.presenter?.successfullyFetched()
    }
    
}

