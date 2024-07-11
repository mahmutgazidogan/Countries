//
//  Helper.swift
//  Countries
//
//  Created by Mahmut Gazi Doğan on 28.01.2024.
//

import UIKit

enum IconType {
    case systemName(String)
    case named(String)
    case url(String)
    
    var image: UIImage? {
        switch self {
        case .systemName(let name):
            return UIImage(systemName: name)
        case .named(let name):
            return UIImage(named: name)
        case .url(_):
            return nil
        }
    }
}

extension UIImageView {
    func setIcon(_ iconType: IconType) {
        switch iconType {
        case .named(_), .systemName(_):
            self.image = iconType.image
        case .url(let url):
            if let url = URL(string: url) {
                self.kf.setImage(with: url)
            }
        }
    }
}

enum AppColor {
    case title
    case subtitle
    case mainBackground
    case contentBackground
    
    var color: UIColor {
        switch self {
        case .title:
            return .label
        case .subtitle:
            return .secondaryLabel
        case .mainBackground:
            return .systemGroupedBackground
        case .contentBackground:
            return .secondarySystemGroupedBackground
        }
    }
}

enum AppConstants  {
    case countries
    case details
    case capital
    case searchBarPlaceholder
    case noDataFound
    case emptyString
    
    var text: String {
        switch self {
        case .countries:
            return "Countries"
        case .details:
            return "Details"
        case .capital:
            return "Capital"
        case .searchBarPlaceholder:
            return "Search any country..."
        case .noDataFound:
            return "No data found!"
        case .emptyString:
            return ""
        }
    }
}
