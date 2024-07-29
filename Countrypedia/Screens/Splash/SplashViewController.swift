//
//  SplashViewController.swift
//  Countries
//
//  Created by Mahmut Doğan on 13.06.2024.
//

import UIKit

final class SplashViewController: UIViewController {
    var presenter: SplashViewToPresenterProtocol?
    private let imageView: UIImageView = {
        let iv = UIImageView(frame: CGRect(x: 0,
                                           y: 0,
                                           width: 300,
                                           height: 300))
        iv.image = UIImage(named: "world")
        return iv
    }()
    
    // MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imageView.center = view.center
        self.animationStarting()
    }
    
    // MARK: View Layout Function
    
    private func setupViews() {
        view.backgroundColor = AppColor.mainBackground.color
        view.addSubview(imageView)
    }
}

// MARK: Extensions

// MARK: Splash View Protocol Functions

extension SplashViewController: ViewProtocol {
    func animationStarting() {
        UIView.animate(withDuration: 1.5, animations: {
            let size = self.view.frame.size.width * 3
            let diffX = size - self.view.frame.width
            let diffY = self.view.frame.height - size
            
            self.imageView.frame = CGRect(x: -(diffX/2),
                                           y: diffY/2,
                                           width: size,
                                           height: size)
        })
        UIView.animate(withDuration: 1.5, animations: {
            self.imageView.alpha = 0
        }, completion: { done in
            if done {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3,
                                              execute: {
                    self.goToHome()
                })
            }
        })
    }
    
    func goToHome() {
        presenter?.showHomeScreen()
    }
}
