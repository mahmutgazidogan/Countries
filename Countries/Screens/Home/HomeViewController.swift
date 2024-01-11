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
        search.searchBar.placeholder = "Search any country..."
        search.searchResultsUpdater = self
        search.delegate = self
        search.searchBar.tintColor = .black
        search.searchBar.searchTextField.backgroundColor = .white
        return search
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Countries"
        label.font = UIFont(name: "AvenirNext-Bold", size: 32)
        return label
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
        segment.backgroundColor = .white
        segment.selectedSegmentTintColor = .systemRed
        segment.apportionsSegmentWidthsByContent = true
        segment.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 8)], for: .normal)
        segment.addTarget(self, action: #selector(segmentedValueChanged), for: .valueChanged)
        return segment
    }()
    
    private lazy var indicator: UIActivityIndicatorView = {
        let ind = UIActivityIndicatorView()
        ind.color = .black
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
        presenter?.interactor?.selectedContinent = selectedContinent
        backToTop()
        showCountries()
    }
    
    private func backToTop() {
        let desiredOffset = CGPoint(x: 0, y: 0)
        collectionView.setContentOffset(desiredOffset, animated: true)
    }
    
    private func titleForSegmentedControl() {
        let allContinents = Continent.allCases.map {
            $0.rawValue
        }
        for (index, title) in allContinents.enumerated() {
            segmented.insertSegment(withTitle: title, at: index, animated: true)
        }
    }
    
    private func getDatas() {
        presenter?.updateUI()
    }
    
    private func setupViews() {
        title = "Countries"
        view.backgroundColor = .systemYellow
        collectionView.backgroundColor = .systemYellow
        navigationItem.searchController = searchController
        view.addSubviews(segmented,
                         collectionView,
                         indicator)
        
        setupLayouts()
        titleForSegmentedControl()
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
    func showCountries() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func startAnimating() {
        indicator.startAnimating()
    }
    
    func stopAnimating() {
        indicator.stopAnimating()
    }
}

extension HomeViewController: UISearchControllerDelegate, UISearchBarDelegate, UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        if searchText.isEmpty {
            presenter?.interactor?.selectedContinent = .all
            showCountries()
        } else {
            segmented.selectedSegmentIndex = 0
            presenter?.getFilteredCountries(searchText: searchText)
//            guard let segmentIndex = presenter?.getSegmentIndex() else { return }
//            segmented.selectedSegmentIndex = segmentIndex
//            segmentedValueChanged(sender: segmented)
            showCountries()
        }
    }
    
    func willDismissSearchController(_ searchController: UISearchController) {
        segmented.selectedSegmentIndex = 0
        presenter?.interactor?.selectedContinent = .all
        showCountries()
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: collectionView.frame.width / 2.4 , height: 150)
        return size
    }
}

extension HomeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        guard let searchText = searchController.searchBar.text else { return 0 }
        if searchText.isEmpty {
            return presenter?.getCountOfFilteredByContinents() ?? 0
        } else {
            return presenter?.getCountOfFilteredCountries() ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.identifier,
                                                            for: indexPath) as? HomeCollectionViewCell else { return UICollectionViewCell() }
        guard let searchText = searchController.searchBar.text else { return UICollectionViewCell() }
        if searchText.isEmpty {
            guard let filteredByContinents = presenter?.getFilteredByContinents() else { return UICollectionViewCell() }
            cell.configure(model: filteredByContinents[indexPath.item])
        } else {
            guard let searchedCountries = presenter?.interactor?.filteredCountries else { return UICollectionViewCell() }
                cell.configure(model: searchedCountries[indexPath.item])
        }
        return cell
    }
    
}

