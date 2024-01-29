//
//  CountriesViewController.swift
//  Countries
//
//  Created by Mahmut Gazi Doğan on 4.11.2023.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController {
    
    var presenter: HomeViewToPresenterProtocol?
    
    private lazy var searchController: UISearchController = {
        let search = UISearchController(searchResultsController: nil)
        search.searchBar.placeholder = AppConstants.searchBarPlaceholder.rawValue
        search.searchResultsUpdater = self
        search.delegate = self
        search.searchBar.tintColor = AppColor.blackTint.color
        search.searchBar.searchTextField.backgroundColor = AppColor.whiteBackground.color
        return search
    }()
    
    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        cv.delegate = self
        cv.dataSource = self
        cv.showsVerticalScrollIndicator = false
        cv.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: HomeCollectionViewCell.identifier)
        return cv
    }()
    
    private lazy var segmented: UISegmentedControl = {
        let segment = UISegmentedControl()
        segment.backgroundColor = AppColor.whiteBackground.color
        segment.selectedSegmentTintColor = AppColor.selectedSegmentedTint.color
        segment.apportionsSegmentWidthsByContent = true
        segment.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 8)], for: .normal)
        segment.addTarget(self, action: #selector(segmentedValueChanged), for: .valueChanged)
        return segment
    }()
    
    private lazy var indicator: UIActivityIndicatorView = {
        let ind = UIActivityIndicatorView()
        ind.color = AppColor.blackTint.color
        ind.style = .large
        return ind
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        getDatas()
    }
    
    @objc private func segmentedValueChanged(sender: UISegmentedControl) {
        let selectedIndex = sender.selectedSegmentIndex
        guard let selectedContinentTitle = segmented.titleForSegment(at: selectedIndex),
              let selectedContinent = Continent(rawValue: selectedContinentTitle) else { return }
        searchController.searchBar.text?.removeAll()
        presenter?.changeContinent(continent: selectedContinent)
        backToTopWhenSegmentChanged()
        reloadData()
    }
    
    private func backToTopWhenSegmentChanged() {
        let desiredOffset = CGPoint(x: 0, y: 0)
        collectionView.setContentOffset(desiredOffset, animated: true)
    }
    
    private func getDatas() {
        presenter?.updateUI()
    }
    
    private func setupViews() {
        title = AppConstants.countries.rawValue
        view.backgroundColor = AppColor.yellowBackground.color
        collectionView.backgroundColor = AppColor.yellowBackground.color
        navigationItem.searchController = searchController
        view.addSubviews(segmented,
                         collectionView,
                         indicator)
        
        setupLayouts()
        presenter?.getTitleForSegmentedControl(segmented: segmented)
        segmented.selectedSegmentIndex = 0
    }
    
    private func setupLayouts() {
        segmented.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(5)
            make.leading.equalToSuperview().offset(5)
            make.trailing.equalToSuperview().offset(-5)
            make.height.equalTo(30)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(segmented.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        indicator.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
}

extension HomeViewController: HomePresenterToViewProtocol {
    func reloadData() {
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    }
    
    func showLoadingIndicator() {
        indicator.startAnimating()
    }
    
    func hideLoadingIndicator() {
        indicator.stopAnimating()
    }
}

extension HomeViewController: UISearchControllerDelegate, UISearchBarDelegate, UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text,
              let presenter else { return }
        if searchText.isEmpty {
            presenter.changeContinent(continent: .all)
            reloadData()
        } else {
            segmented.selectedSegmentIndex = 0
            presenter.getSearchedCountries(searchText: searchText)
            reloadData()
        }
    }
    
    func willDismissSearchController(_ searchController: UISearchController) {
        guard let presenter else { return }
        segmented.selectedSegmentIndex = 0
        presenter.changeContinent(continent: .all)
        reloadData()
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: collectionView.frame.width / 2.4 , height: 150)
        return size
    }
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        guard let searchText = searchController.searchBar.text,
              let presenter,
              let filteredByContinents = presenter.getFilteredByContinents(),
              let searchedCountries = presenter.interactor.searchedCountries else { return }
        if searchText.isEmpty {
            let country = filteredByContinents[indexPath.item]
            presenter.didSelectItemAt(country: country)
        } else {
            let country = searchedCountries[indexPath.item]
            presenter.didSelectItemAt(country: country)
        }
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        guard let searchText = searchController.searchBar.text,
              let presenter,
              let countOfFilteredByContinents = presenter.getCountOfFilteredByContinents(),
              let countOfFilteredCountries = presenter.getCountOfSearchedCountries() else { return 0 }
        if searchText.isEmpty {
            return countOfFilteredByContinents
        } else {
            return countOfFilteredCountries
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.identifier,
                                                            for: indexPath) as? HomeCollectionViewCell,
              let searchText = searchController.searchBar.text,
              let presenter = presenter,
              let filteredByContinents = presenter.getFilteredByContinents(),
              let searchedCountries = presenter.interactor.searchedCountries else { return UICollectionViewCell() }
        if searchText.isEmpty {
            cell.configure(model: filteredByContinents[indexPath.item])
        } else {
            cell.configure(model: searchedCountries[indexPath.item])
        }
        return cell
    }
}

