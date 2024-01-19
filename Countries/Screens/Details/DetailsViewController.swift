//
//  DetailsViewController.swift
//  Countries
//
//  Created by Mahmut Gazi Doğan on 19.01.2024.
//

import UIKit

class DetailsViewController: UIViewController {
    
    var presenter: DetailsViewToPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemYellow
    }
    
}

extension DetailsViewController: DetailsPresenterToViewProtocol {
    
}
