//
//  FavoritesViewController.swift
//  Countrypedia
//
//  Created by Mahmut Doğan on 13.07.2024.
//

import UIKit

class FavoritesViewController: UIViewController {
    var presenter: FavoritesViewToPresenterProtocol?
    let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
    
    // MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Favorites"
        view.addSubview(imageView)
        imageView.center = view.center
        view.backgroundColor = #colorLiteral(red: 0.9982071519, green: 0.7682781219, blue: 0.06974165887, alpha: 1)
        imageView.tintColor = #colorLiteral(red: 0.7280498147, green: 0.1115937606, blue: 0.2542278767, alpha: 1)
        imageView.contentMode = .scaleAspectFit
        imageView.setIcon(.systemName("heart.fill"))
    }
    
}

// MARK: Extensions

// MARK: FavoritesPresenterToViewProtocol Functions

extension FavoritesViewController: FavoritesPresenterToViewProtocol {
    
}
