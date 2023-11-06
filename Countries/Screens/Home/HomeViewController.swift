//
//  CountriesViewController.swift
//  Countries
//
//  Created by Mahmut Gazi Doğan on 4.11.2023.
//

import UIKit

class HomeViewController: UIViewController {
    
    var presenter: HomeViewToPresenterProtocol? = HomePresenter()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getDatas()
    }
    
    private func getDatas() {
        presenter?.updateUI()
    }

}

extension HomeViewController: HomePresenterToViewProtocol { }
