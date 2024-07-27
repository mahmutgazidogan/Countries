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
                    $0.name?.common?.lowercased() ?? AppConstants.emptyString.text
                    < $1.name?.common?.lowercased() ?? AppConstants.emptyString.text
                }
                self?.presenter?.reloadData()
                self?.presenter?.hideLoadingIndicator()
            case .failure(_):
                self?.presenter?.showAlert(title: "Error!",
                                           message: "An error occurred while fetching the country list! Please check your internet connetcion or try again later!",
                                           tryAgainHandler: { [weak self] _ in self?.fetchAllCountries()},
                                           exitHandler: { _ in exit(0) })
                self?.presenter?.hideLoadingIndicator()
            }
        }
    }
    
    private func filterByContinents() -> [Country]? {
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
    
    private func countOfFilteredByContinents() -> Int? {
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
    
    private func countOfSearchedCountries() -> Int? {
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
    
    func toggleFavorite(country: Country) {
        if let index = countryList?.firstIndex(where: { $0.name?.common == country.name?.common }) {
            countryList?[index].isFavorited.toggle()
        }
    }
    
    // MARK: CollectionView Functions
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int,
                        searchController: UISearchController) -> Int {
        guard let searchText = searchController.searchBar.text,
              let countOfFilteredByContinents = countOfFilteredByContinents(),
              let countOfSearchedCountries = countOfSearchedCountries() else { return 0 }
        if searchText.isEmpty {
            return countOfFilteredByContinents
        } else {
            return countOfSearchedCountries
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath,
                        viewController: UIViewController,
                        searchController: UISearchController) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CommonCollectionViewCell.identifier,
                                                            for: indexPath) as? CommonCollectionViewCell,
              let searchText = searchController.searchBar.text,
              let filteredByContinents = filterByContinents(),
              let searchedCountries = searchedCountries else { return UICollectionViewCell() }
        if searchText.isEmpty {
            cell.configure(model: filteredByContinents[indexPath.item])
        } else {
            cell.configure(model: searchedCountries[indexPath.item])
        }
        cell.delegate = viewController as? CommonCellDelegate 
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath,
                        searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text,
              let filteredByContinents = filterByContinents(),
              let searchedCountries = searchedCountries else { return }
        if searchText.isEmpty {
            let country = filteredByContinents[indexPath.item]
            presenter?.didSelectItemAt(country: country)
        } else {
            let country = searchedCountries[indexPath.item]
            presenter?.didSelectItemAt(country: country)
        }
    }
}
