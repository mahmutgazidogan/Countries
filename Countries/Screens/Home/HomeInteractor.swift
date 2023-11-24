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
    var selectedContinent: Continent = .africa
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
    
    
    func filterByContinents() -> [Country]? {
        guard let countryList = self.countryList else { return [] }
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
    
    func countOfFilteredByContinents() -> Int? {
        let filteredByContinents = filterByContinents()
        return filteredByContinents?.count
    }
    
    func filteredCountries(searchText: String) {
//        guard let searchedCountries = filterByContinents() else { return }
        filteredCountries = countryList?.filter({ country in
            country.name?.common?.lowercased().contains(searchText.lowercased()) ?? false
        })
        self.presenter?.successfullyFetched()
        
        
//        let filterByContinents = filterByContinents()
//        filteredCountries = filterByContinents?.filter({ country in
//            country.name?.common?.lowercased().contains(searchText.lowercased()) ?? false
//        })
//        presenter?.successfullyFetched()
        
    }
    
    func countOfFilteredCountries() -> Int? {
        return filteredCountries?.count
    }
    
    func findSegmentIndex() -> Int? {
        var segmentIndex: Int?
        guard let firstResult = filteredCountries?.first,
              let continents = firstResult.continents else { return nil }
        for continent in continents {
            segmentIndex = Continent.allCases.lastIndex(of: continent)
        }
        return segmentIndex
    }
    
}

