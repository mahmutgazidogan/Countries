//
//  HomeInteractor.swift
//  Countries
//
//  Created by Mahmut Gazi Doğan on 4.11.2023.
//

import UIKit

final class HomeInteractor: HomePresenterToInteractorProtocol {
    
    var presenter: HomeInteractorToPresenterProtocol?
    var countryList: Countries? = []
    var searchedCountries: Countries? = []
    var selectedContinent: Continent? = .all
    
    func fetchAllCountries() {
        presenter?.showLoadingIndicator()
        NetworkingManager.shared.routerRequest(request: Router.allCountries) { [weak self] (result: Result<Countries, Error>) in
            switch result {
            case .success(let data):
                self?.countryList = data.sorted {
                    $0.name?.common?.lowercased() ?? AppConstants.emptyString.text < $1.name?.common?.lowercased() ?? AppConstants.emptyString.text
                }
                self?.presenter?.reloadData()
                self?.presenter?.hideLoadingIndicator()
            case .failure(let error):
                self?.presenter?.showAlert(title: "Hata!",
                                           message: "Ülkeler listesi getirilirken bir hata oluştu!\n Hata İçeriği: \(error.localizedDescription)")
            }
        }
    }
    
    func titleForSegmentedControl(segmented: UISegmentedControl) {
        let allContinents = Continent.allCases.map {
            $0.rawValue
        }
        for (index, title) in allContinents.enumerated() {
            segmented.insertSegment(withTitle: title, at: index, animated: true)
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
        guard let filteredByContinents = filterByContinents() else { return 0 }
        return filteredByContinents.count
    }
    
    func searchedCountries(searchText: String) {
        if searchText.isEmpty {
            searchedCountries = countryList
            self.presenter?.reloadData()
        } else {
            searchedCountries = countryList?.filter({ country in
                guard let countryName = country.name?.common else { return false }
                return countryName.lowercased().hasPrefix(searchText.lowercased())
            })
        }
        self.presenter?.reloadData()
    }
    
    func countOfSearchedCountries() -> Int? {
        return searchedCountries?.count
    }
    
    func changeContinent(segmented: UISegmentedControl) {
        let selectedIndex = segmented.selectedSegmentIndex
        guard let selectedContinentTitle = segmented.titleForSegment(at: selectedIndex),
              let selectedContinent = Continent(rawValue: selectedContinentTitle) else { return }
        if selectedIndex != 0 {
            self.selectedContinent = selectedContinent
        } else {
            self.selectedContinent = .all
        }
    }
}

