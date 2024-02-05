//
//  Helper.swift
//  Countries
//
//  Created by Mahmut Gazi Doğan on 28.01.2024.
//

import UIKit

enum AppColor {
    case yellowBackground
    case blackTint
    case whiteBackground
    case selectedSegmentedTint
    case clearBackground
    case grayBorder
    
    var color: UIColor {
        switch self {
        case .yellowBackground:
            return UIColor.systemYellow
        case .blackTint:
            return UIColor.black
        case .whiteBackground:
            return UIColor.white
        case .selectedSegmentedTint:
            return UIColor.systemRed
        case .clearBackground:
            return UIColor.clear
        case .grayBorder:
            return UIColor.gray
        }
    }
}

enum AppConstants  {
    case countries
    case searchBarPlaceholder
    case emptyString
    
    var text: String {
        switch self {
        case .countries:
            return "Countries"
        case .searchBarPlaceholder:
            return "Search any country..."
        case .emptyString:
            return ""
        }
    }
}

enum Icons: String {
    case tick = "tick"
    case cross = "cross"
    
    var image: UIImage? {
        return UIImage(named: self.rawValue)
    }
}


