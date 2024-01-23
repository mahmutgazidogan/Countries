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
    var selectedContinent: Continent? = .all
    
    func fetchAllCountries() {
        presenter?.startAnimating()
        NetworkingManager.shared.routerRequest(request: Router.allCountries) { [weak self] (result: Result<Countries, Error>) in
            switch result {
            case .success(let data):
                self?.countryList = data.sorted {
                    $0.name?.common?.lowercased() ?? "" < $1.name?.common?.lowercased() ?? ""
                }
                
                self?.presenter?.successfullyFetched()
                self?.presenter?.stopAnimating()
            case .failure(let error):
                
                // TODO: Alert view'da çıkacak ama interactor karar verecek
                
                print(String(describing: error))
            }
        }
    }
    
    func filterByContinents() -> [Country]? {
        guard let countryList else { return [] }
        if selectedContinent == .all {
            return countryList
        } else {
            let filteredByContinents = countryList.filter({ item in
                if let continents = item.continents {
                    for continent in continents {
                        return continent == selectedContinent
                    }
                }
                return true
            })
            return filteredByContinents
        }
    }
    
    func countOfFilteredByContinents() -> Int? {
        let filteredByContinents = filterByContinents()
        return filteredByContinents?.count
    }
    
    func filteredCountries(searchText: String) {
        if searchText.isEmpty {
            filteredCountries = countryList
            self.presenter?.successfullyFetched()
        } else {
            filteredCountries = countryList?.filter({ country in
                guard let countryName = country.name?.common else { return false }
                return countryName.lowercased().hasPrefix(searchText.lowercased())
            })
        }
        self.presenter?.successfullyFetched()
    }
    
    
    
    func filterCountriesFor(searchText: String = "") -> [Country]? {
        guard let countryList = countryList else { return [] }
        if searchText == "" {
            
            
            if selectedContinent == .all {
                filteredCountries = countryList
//                presenter?.successfullyFetched()
                return filteredCountries
                
            } else {
                filteredCountries = countryList.filter({ item in
                    if let continents = item.continents {
                        for continent in continents {
                            return continent == selectedContinent
                        }
                    }
                    return true
                })
//                presenter?.successfullyFetched()
                return filteredCountries
                
            }
            
        } else {
            filteredCountries = countryList.filter({ country in
                guard let countryName = country.name?.common else { return false }
                return countryName.lowercased().hasPrefix(searchText.lowercased())
            })
        }
//        presenter?.successfullyFetched()
        return filteredCountries
        
    }
    
    func countOfFilteredCountries() -> Int? {
        return filteredCountries?.count
    }
    
    func changeContinent(continent: Continent) {
        selectedContinent = continent
    }
}

