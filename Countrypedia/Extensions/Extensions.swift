//
//  Extensions.swift
//  Countries
//
//  Created by Mahmut Gazi Doğan on 4.11.2023.
//

import UIKit
import SnapKit

// MARK: CollectionView Extensions

class SectionHeaderView: UICollectionReusableView {
    static let reuseIdentifier = "SectionHeaderView"
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.contentMode = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        titleLabel.textAlignment = .left
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.centerX.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UICollectionView {
    public func hideableShowableTabBar(_ scrollView: UIScrollView) {
        guard let tabBar = (scrollView.delegate as? UIViewController)?.tabBarController?.tabBar else { return }
        
        let translation = scrollView.panGestureRecognizer.translation(in: scrollView.superview)
        
        if translation.y > 0 {
            // Scroll down - show tabBar
            UIView.animate(withDuration: 0.3) {
                tabBar.frame.origin.y = UIScreen.main.bounds.height - tabBar.frame.height
            }
        } else if translation.y < 0 {
            // Scroll up - hide tabBar
            UIView.animate(withDuration: 0.3) {
                tabBar.frame.origin.y = UIScreen.main.bounds.height
            }
        }
    }
}

// MARK: ViewController Extension

extension UIViewController {
    func showAlert(title: String, 
                   message: String,
                   tryAgainHandler: ((UIAlertAction) -> Void)?,
                   exitHandler: ((UIAlertAction) -> Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let tryAgainAction = UIAlertAction(title: "Try Again", style: .default, handler: tryAgainHandler)
        let exitAction = UIAlertAction(title: "Exit", style: .destructive, handler: exitHandler)
        alert.addAction(tryAgainAction)
        alert.addAction(exitAction)
        self.present(alert, animated: true, completion: nil)
    }
}

// MARK: View Extensions


extension UIStackView {
    func addArrangedSubviews(_ view: UIView...) {
        view.forEach({ v in
            self.addArrangedSubview(v)
        })
    }
}

extension UIView {
    
    /// Add multiple subview to a view.
    /// - Parameter view: It is a subviews array which add to parent view
    func addSubviews(_ view: UIView...) {
        view.forEach({ v in
            self.addSubview(v)
        })
    }
    func addShadow() {
        layer.shadowColor = AppColor.title.color.cgColor
        layer.shadowOpacity = 0.25
        layer.shadowRadius = 2.5
        clipsToBounds = false
    }
    func addCornerRadius(corners: CACornerMask, radius: CGFloat) {
        layer.cornerRadius = radius
        layer.maskedCorners = corners
        layer.masksToBounds = true
    }
}
