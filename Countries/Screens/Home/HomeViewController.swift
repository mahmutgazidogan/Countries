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
        search.searchBar.placeholder = AppConstants.searchBarPlaceholder.text
        search.searchResultsUpdater = self
        search.delegate = self
        search.searchBar.tintColor = AppColor.blackTint.color
        search.searchBar.searchTextField.backgroundColor = AppColor.whiteBackground.color
        return search
    }()
    
    private lazy var customView: DesignableView = {
        let view = DesignableView()
        view.backgroundColor = .cyan
        view.animation = "slideUp"
        view.duration = 2
        view.damping = 1
        view.animate()
        return view
    }()
    
    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        cv.delegate = self
        cv.dataSource = self
        cv.showsVerticalScrollIndicator = false
        cv.register(HomeCollectionViewCell.self,
                    forCellWithReuseIdentifier: HomeCollectionViewCell.identifier)
        cv.register(SectionHeaderView.self,
                    forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                    withReuseIdentifier: SectionHeaderView.reuseIdentifier)
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        view.backgroundColor = AppColor.yellowBackground.color
        segmentedValueChanged(sender: segmented)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        customView.layer.cornerRadius = 80
        customView.layer.maskedCorners = [.layerMaxXMinYCorner,
                                          .layerMinXMinYCorner]
        customView.layer.masksToBounds = true
    }
    
    @objc private func segmentedValueChanged(sender: UISegmentedControl) {
        searchController.searchBar.text?.removeAll()
        presenter?.changeContinent(segmented: sender)
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
        title = AppConstants.countries.text
        collectionView.backgroundColor = .green
        navigationItem.searchController = searchController
        view.addSubviews(segmented, customView)
        customView.addSubviews(collectionView, indicator)
        
        setupLayouts()
        presenter?.getTitleForSegmentedControl(segmented: segmented)
        segmented.selectedSegmentIndex = 0
    }
    
    private func setupLayouts() {
        segmented.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(5)
            make.leading.trailing.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.05)
        }
        
        customView.snp.makeConstraints { make in
            make.top.equalTo(segmented.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
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
    
    func showAlert(title: String, message: String) {
        showAlert(title: title, message: message, handler: nil)
    }
}

extension HomeViewController: UISearchControllerDelegate, UISearchBarDelegate, UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text,
              let presenter else { return }
        if searchText.isEmpty {
            if !searchController.isActive {
                presenter.changeContinent(segmented: segmented)
            }
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
        presenter.changeContinent(segmented: segmented)
        reloadData()
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        let count = collectionView.numberOfItems(inSection: indexPath.section)
        if kind == UICollectionView.elementKindSectionHeader {
            guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                                   withReuseIdentifier: SectionHeaderView.reuseIdentifier,
                                                                                   for: indexPath) as? SectionHeaderView
            else {
                return UICollectionReusableView()
            }
            headerView.titleLabel.text = "\(count) countries listed."
            return headerView
        }
        return UICollectionReusableView()
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 30)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: view.frame.width / 2.4 , height: view.frame.height / 5)
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
//        guard let searchText = searchController.searchBar.text,
//              let presenter,
//              let filteredByContinents = presenter.getFilteredByContinents(),
//              let searchedCountries = presenter.interactor.searchedCountries else { return }
//        if searchText.isEmpty {
//            let country = filteredByContinents[indexPath.item]
//            presenter.didSelectItemAt(country: country)
//        } else {
//            let country = searchedCountries[indexPath.item]
//            presenter.didSelectItemAt(country: country)
//        }
        presenter?.getSelectedItem(collectionView,
                                   didSelectItemAt: indexPath,
                                   searchController: searchController)
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
//        guard let searchText = searchController.searchBar.text,
//              let presenter,
//              let countOfFilteredByContinents = presenter.getCountOfFilteredByContinents(),
//              let countOfFilteredCountries = presenter.getCountOfSearchedCountries() else { return 0 }
//        if searchText.isEmpty {
//            return countOfFilteredByContinents
//        } else {
//            return countOfFilteredCountries
//        }
        
        guard let numberOfItems = presenter?.getNumberOfItems(collectionView,
                                                numberOfItemsInSection: section,
                                                searchController: searchController) else { return 0 }
        return numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.identifier,
//                                                            for: indexPath) as? HomeCollectionViewCell,
//              let searchText = searchController.searchBar.text,
//              let presenter,
//              let filteredByContinents = presenter.getFilteredByContinents(),
//              let searchedCountries = presenter.interactor.searchedCountries else { return UICollectionViewCell() }
//        if searchText.isEmpty {
//            cell.configure(model: filteredByContinents[indexPath.item])
//        } else {
//            cell.configure(model: searchedCountries[indexPath.item])
//        }
//        return cell
        
        guard let cell = presenter?.getCell(collectionView,
                                            cellForItemAt: indexPath,
                                            searchController: searchController) else { return UICollectionViewCell() }
        return cell
    }
}

