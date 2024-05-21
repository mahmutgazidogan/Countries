//
//  Helper.swift
//  Countries
//
//  Created by Mahmut Gazi Doğan on 28.01.2024.
//

import UIKit

enum AppFont {
    static let regular = "ArialMT"
    static let bold = "Arial-BoldMT"
}

enum FontSize {
    case small
    case medium
    case large
    
    var fontSize: CGFloat {
        switch self {
        case .small:
            return UIFont.preferredFont(forTextStyle: .body).pointSize * 0.8 // Örnek bir oran
        case .medium:
            return UIFont.preferredFont(forTextStyle: .body).pointSize
        case .large:
            return UIFont.preferredFont(forTextStyle: .body).pointSize * 1.2 // Örnek bir oran
        }
    }
}

enum AppColor {
    case yellowBackground
    case blackTint
    case whiteBackground
    case selectedSegmentedTint
    case clearBackground
    case grayBorder
    case lightTextBackground
    
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
        case .lightTextBackground:
            return UIColor.lightText
        }
    }
}

enum AppConstants  {
    case countries
    case capital
    case searchBarPlaceholder
    case emptyString
    
    var text: String {
        switch self {
        case .countries:
            return "Countries"
        case .capital:
            return "Capital"
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


