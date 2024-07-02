//
//  SplashViewController.swift
//  Countries
//
//  Created by Mahmut Doğan on 13.06.2024.
//

import UIKit

final class SplashViewController: UIViewController {
    var presenter: SplashViewToPresenterProtocol?
    let imageView: UIImageView = {
        let iv = UIImageView(frame: CGRect(x: (UIScreen.main.bounds.width - 300) / 2,
                                                   y: (UIScreen.main.bounds.height - 300) / 2,
                                                   width: 300,
                                                   height: 300))
        iv.image = UIImage(named: "dünya")
        return iv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        animationStarting()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imageView.center = view.center
    }
    
    private func setupViews() {
        view.backgroundColor = AppColor.mainBackground.color
        view.addSubview(imageView)
    }
}

extension SplashViewController: ViewProtocol {
    func animationStarting() {
        UIView.animate(withDuration: 3, animations: { [weak self] in
            let size = (self?.view.frame.size.width ?? 0.0)
            let diffX = size - (self?.view.frame.width ?? 0.0)
            let diffY = (self?.view.frame.height ?? 0.0) - size
            
            self?.imageView.frame = CGRect(x: -(diffX/2),
                                           y: diffY/2,
                                           width: size,
                                           height: size)
        })
        UIView.animate(withDuration: 2, animations: { [weak self] in
            self?.imageView.alpha = 0
        }) { done in
            if done {
                DispatchQueue.main.asyncAfter(deadline: .now(),
                                              execute: {
                    self.goToHome()
                })
            }
        }
    }
    
    func goToHome() {
        presenter?.showHomeScreen()
    }
}

