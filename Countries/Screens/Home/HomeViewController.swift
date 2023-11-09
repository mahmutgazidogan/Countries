//
//  CountriesViewController.swift
//  Countries
//
//  Created by Mahmut Gazi Doğan on 4.11.2023.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController {
    
    var presenter: HomeViewToPresenterProtocol? //= HomePresenter()
    
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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        getDatas()
    }
    
    override func viewDidLayoutSubviews() {
        searchBar.layer.cornerRadius = 20
        searchBar.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner]
        searchBar.layer.masksToBounds = true
        searchBar.layer.borderColor = UIColor.gray.cgColor
        searchBar.layer.borderWidth = 0.5
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
                         collectionView)
        
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
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
}

extension HomeViewController: HomePresenterToViewProtocol {
    func showCountries() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}

extension HomeViewController: UISearchBarDelegate { }

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: collectionView.frame.width / 2.4 , height: 150)
        return size
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.getCountryListCount() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.identifier, for: indexPath) as? HomeCollectionViewCell else { return UICollectionViewCell() }
        let countries = presenter?.getAllCountries()
        cell.configure(model: countries![indexPath.row])
        return cell
    }
    
    
}

