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

enum AppConstants: String  {
    case countries = "Countries"
    case searchBarPlaceholder = "Search any country..."
    case emptyString = ""
}


