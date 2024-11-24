//
//  FavoritesViewController.swift
//  Countrypedia
//
//  Created by Mahmut Doğan on 13.07.2024.
//

import UIKit
import SnapKit

class FavoritesViewController: UIViewController {
    var presenter: FavoritesViewToPresenterProtocol?
//    let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
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
        cv.register(CommonCollectionViewCell.self,
                    forCellWithReuseIdentifier: CommonCollectionViewCell.identifier)
        cv.register(SectionHeaderView.self,
                    forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                    withReuseIdentifier: SectionHeaderView.reuseIdentifier)
        return cv
    }()
    // MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        setupViews()
        presenter?.fetchFavorites()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        view.backgroundColor = AppColor.mainBackground.color
        presenter?.fetchFavorites()
    }
    
    private func setupViews() {
        title = AppConstants.favorites.text
        collectionView.backgroundColor = AppColor.mainBackground.color
        view.addSubviews(collectionView)
        
        setupLayouts()
    }
    
    private func setupLayouts() {
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
}

// MARK: Extensions
// MARK: CollectionView Delegate & DataSource Functions

extension FavoritesViewController: UICollectionViewDelegateFlowLayout {
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
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        collectionView.hideableShowableTabBar(scrollView)
    }
}

extension FavoritesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let numberOfItems = presenter?.numberOfItems() else { return 0 }
        return numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CommonCollectionViewCell.identifier, for: indexPath) as? CommonCollectionViewCell,
                let favorite = presenter?.getItem(indexPath: indexPath) else {
            return UICollectionViewCell()
        }
        cell.configure(coreData: favorite)
        cell.delegate = self
        return cell
    }
}

// MARK: FavoritesPresenterToViewProtocol Functions

extension FavoritesViewController: FavoritesPresenterToViewProtocol {
    func reloadData() {
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    }
}

// MARK: CommonCellDelegate Protocol Function

extension FavoritesViewController: CommonCellDelegate {
    func didTapFavoriteButton(on cell: CommonCollectionViewCell) {
        if let indexPath = collectionView.indexPath(for: cell) {
            presenter?.toggleFavorite(indexPath: indexPath)
        }
    }
}
