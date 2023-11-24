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
//    var selectedContinent: Continent = .africa
    
    private lazy var searchBar: UISearchBar = {
        let search = UISearchBar()
        search.placeholder = "Search any country..."
        search.delegate = self
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
        segment.selectedSegmentIndex = 0
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
        titleForSegmentedControl()
        getDatas()
    }
    
    override func viewDidLayoutSubviews() {
        searchBar.layer.cornerRadius = 20
        searchBar.layer.maskedCorners = [.layerMaxXMaxYCorner,
                                         .layerMaxXMinYCorner,
                                         .layerMinXMaxYCorner,
                                         .layerMinXMinYCorner]
        searchBar.layer.masksToBounds = true
        searchBar.layer.borderColor = UIColor.gray.cgColor
        searchBar.layer.borderWidth = 0.5
    }
    
    @objc private func segmentedValueChanged(sender: UISegmentedControl) {
        let selectedIndex = sender.selectedSegmentIndex
        guard let selectedContinentTitle = segmented.titleForSegment(at: selectedIndex),
              let selectedContinent = Continent(rawValue: selectedContinentTitle) else { return }
        presenter?.interactor?.selectedContinent = selectedContinent
        
        let desiredOffset = CGPoint(x: 0, y: 0)
        collectionView.setContentOffset(desiredOffset, animated: true)
        
        showCountries()
    }
    
    private func titleForSegmentedControl() {
        UILabel.appearance(whenContainedInInstancesOf: [UISegmentedControl.self]).numberOfLines = 0
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
        view.backgroundColor = .systemYellow
        searchBar.searchTextField.backgroundColor = .white
        collectionView.backgroundColor = .systemYellow
        navigationController?.isNavigationBarHidden = true
        view.addSubviews(searchBar,
                         titleLabel,
                         segmented,
                         collectionView,
                         indicator)
        
        setupLayouts()
    }
    
    private func setupLayouts() {
        
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(20)
        }
        
        segmented.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
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

extension HomeViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }
        if searchText == "" {
            presenter?.interactor?.isSearching = false
        } else {
            presenter?.interactor?.isSearching = true
            presenter?.getFilteredCountries(searchText: searchText)
            guard let segmentIndex = presenter?.getSegmentIndex() else { return }
            segmented.selectedSegmentIndex = segmentIndex
            segmentedValueChanged(sender: segmented)
            showCountries()
        }
    }
    
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        if searchText == "" {
//            presenter?.interactor?.isSearching = false
//        } else {
//            presenter?.interactor?.isSearching = true
//            presenter?.getFilteredCountries(searchText: searchText)
//            showCountries()
//        }
//    }
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
        if presenter?.interactor?.isSearching == false {
            return presenter?.getCountOfFilteredByContinents() ?? 0
        } else {
            return presenter?.getCountOfFilteredCountries() ?? 0
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.identifier,
                                                            for: indexPath) as? HomeCollectionViewCell else { return UICollectionViewCell() }
        if presenter?.interactor?.isSearching == false {
            guard let filteredByContinents = presenter?.getFilteredByContinents() else { return UICollectionViewCell() }
            cell.configure(model: filteredByContinents[indexPath.item])
        } else {
            if let searchedCountries = presenter?.interactor?.filteredCountries {
                cell.configure(model: searchedCountries[indexPath.item])
            }
        }
        return cell
    }
    
}

