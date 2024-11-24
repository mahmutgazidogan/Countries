//
//  Helper.swift
//  Countries
//
//  Created by Mahmut Gazi Doğan on 28.01.2024.
//

import UIKit

// MARK: IconType Enum

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

// MARK: UIImageView Extension

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

// MARK: AppColor Enum

enum AppColor {
    case title
    case subtitle
    case mainBackground
    case contentBackground
    case border
    
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
        case .border:
            return .darkGray
        }
    }
}

// MARK: AppConstants Enum

enum AppConstants  {
    case countries
    case details
    case favorites
    case capital
    case searchBarPlaceholder
    case noDataFound
    case countriesLoading
    case noSuchCountryFound
    case listedCountries(Int)
    case emptyString
    
    var text: String {
        switch self {
        case .countries:
            return "Countries"
        case .details:
            return "Details"
        case .favorites:
            return "Favorites"
        case .capital:
            return "Capital"
        case .searchBarPlaceholder:
            return "Search any country..."
        case .noDataFound:
            return "No data found!"
        case .countriesLoading:
            return "Countries are loading..."
        case .noSuchCountryFound:
            return "No such country found!"
        case .listedCountries(let count):
            return "\(count) countries listed."
        case .emptyString:
            return ""
        }
    }
}
