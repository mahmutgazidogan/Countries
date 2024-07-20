//
//  CountriesViewController.swift
//  Countries
//
//  Created by Mahmut Gazi Doğan on 4.11.2023.
//

import UIKit
import SnapKit

final class HomeViewController: UIViewController {
    var presenter: HomeViewToPresenterProtocol?
    private lazy var searchController: UISearchController = {
        let search = UISearchController(searchResultsController: nil)
        search.searchBar.placeholder = AppConstants.searchBarPlaceholder.text
        search.searchResultsUpdater = self
        search.delegate = self
        search.searchBar.searchTextField.backgroundColor = AppColor.mainBackground.color
        return search
    }()
    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        flowLayout.minimumInteritemSpacing = 20.0
        flowLayout.minimumLineSpacing = 20.0
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
    private lazy var segmentedControl: UISegmentedControl = {
        let segment = UISegmentedControl()
        segment.backgroundColor = AppColor.mainBackground.color
        segment.apportionsSegmentWidthsByContent = true
        segment.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 8)], for: .normal)
        segment.addTarget(self, action: #selector(segmentedValueChanged), for: .valueChanged)
        return segment
    }()
    private lazy var indicator: UIActivityIndicatorView = {
        let ind = UIActivityIndicatorView()
        ind.color = AppColor.title.color
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
        
        view.backgroundColor = AppColor.mainBackground.color
        segmentedValueChanged(sender: segmentedControl)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        searchController.searchBar.addShadow()
        segmentedControl.addShadow()
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
        collectionView.backgroundColor = AppColor.mainBackground.color
        navigationItem.searchController = searchController
        view.addSubviews(segmentedControl, collectionView, indicator)
        titleForSegmentedControl()
        setupLayouts()
        segmentedControl.selectedSegmentIndex = 0
    }
    
    private func titleForSegmentedControl() {
        let allContinents = Continent.allCases.map { $0.rawValue }
        for (index, title) in allContinents.enumerated() {
            segmentedControl.insertSegment(withTitle: title, at: index, animated: true)
        }
    }
    
    private func setupLayouts() {
        segmentedControl.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(5)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(30)
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(segmentedControl.snp.bottom)
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

extension HomeViewController: UIScrollViewDelegate {}

extension HomeViewController: UISearchControllerDelegate, UISearchBarDelegate, UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text,
              let presenter else { return }
        if searchText.isEmpty {
            if !searchController.isActive {
                presenter.changeContinent(segmented: segmentedControl)
            }
            reloadData()
        } else {
            segmentedControl.selectedSegmentIndex = 0
            presenter.getSearchedCountries(searchText: searchText)
            reloadData()
        }
    }
    func willDismissSearchController(_ searchController: UISearchController) {
        guard let presenter else { return }
        segmentedControl.selectedSegmentIndex = 0
        presenter.changeContinent(segmented: segmentedControl)
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
            else { return UICollectionReusableView() }
            headerView.titleLabel.textColor = AppColor.title.color
            if count == 0 {
                headerView.titleLabel.text = "Countries are loading..."
            } else {
                headerView.titleLabel.text = "\(count) countries listed."
            }
            return headerView
        }
        return UICollectionReusableView()
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, 
                      height: 30)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: view.frame.width / 2.4,
                          height: view.frame.height / 5)
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        presenter?.getSelectedItem(collectionView,
                                   didSelectItemAt: indexPath,
                                   searchController: searchController)
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        guard let numberOfItems = presenter?.getNumberOfItems(collectionView,
                                                numberOfItemsInSection: section,
                                                searchController: searchController) else { return 0 }
        return numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = presenter?.getCell(collectionView,
                                            cellForItemAt: indexPath,
                                            searchController: searchController) else { return UICollectionViewCell() }
        return cell
    }
}
