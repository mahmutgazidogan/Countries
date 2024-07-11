//
//  String + Extension.swift
//  Countries
//
//  Created by Mahmut Doğan on 20.06.2024.
//

import Foundation

extension String {
    static func returnCapital(details: Country) -> String {
        if let capital = details.capital?.joined(separator: ", ") {
            return capital.uppercased()
        } else {
            return AppConstants.noDataFound.text
        }
    }
    
    static func returnIndependency(details: Country) -> String {
        if let independent = details.independent {
            return independent ? "Independent" : "Not Independent"
        } else {
            return "Independent"
        }
    }
    
    static func returnSign(details: Country) -> String {
        if let sign = details.car?.signs?.first {
            return sign.isEmpty ? AppConstants.noDataFound.text : sign
        }
        return AppConstants.noDataFound.text
    }
    
    static func returnSide(details: Country) -> String {
        if let side = details.car?.side?.rawValue.capitalized {
            return side.isEmpty ? AppConstants.noDataFound.text : side
        }
        return AppConstants.noDataFound.text
    }
    
    static func returnFlagDescription(details: Country) -> String {
        if let description = details.flags?.alt {
            return description
        } else {
            return AppConstants.noDataFound.text
        }
    }
    
    static func returnLanguages(details: Country) -> String {
        if let languages = details.languages {
            let languageNames = languages.map({ (_, language) in
                language
            }).joined(separator: ", ")
            return languageNames
        } else {
            return AppConstants.noDataFound.text
        }
    }
    
    static func returnTimezones(details: Country) -> String {
        if let timezones = details.timezones {
            return timezones.joined(separator: ", ")
        } else {
            return AppConstants.noDataFound.text
        }
    }
    
    static func numberFormatter(number: Double) -> String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        let intValue = Int(number)
        return formatter.string(from: NSNumber(value: intValue))
    }
    
    static func returnCountryCode(details: Country) -> String {
        guard let idd = details.idd,
              let root = idd.root,
              let suffixes = idd.suffixes else {
            return AppConstants.noDataFound.text
        }
        for suffix in suffixes {
            if root == "+1" {
                return "\(root) \(suffix)"
            } else {
                return "\(root)\(suffix)"
            }
        }
        return AppConstants.noDataFound.text
    }
    
    static func returnCurrencies(details: Country) -> String {
        var string = ""
        if let currencies = details.currencies {
            let allCurrencies = getAllCurrencyInfo(from: currencies)
            for (index, currency) in allCurrencies.enumerated() {
                string += "\(currency.name.capitalized) (\(currency.symbol.capitalized))"
                if index < allCurrencies.count - 1 {
                    string += ", "
                }
            }
        } else {
            string = AppConstants.noDataFound.text
        }
        return string
    }
    
    private static func getAllCurrencyInfo(from currencies: Currencies) -> [(name: String, symbol: String)] {
        var currencyInfo: [(name: String, symbol: String)] = []
        let mirror = Mirror(reflecting: currencies)
        for child in mirror.children {
            if let currency = child.value as? Aed,
               let name = currency.name,
               let symbol = currency.symbol {
                let info = (name: name, symbol: symbol)
                currencyInfo.append(info)
            } else if let bamCurrency = child.value as? BAM,
                      let name = bamCurrency.name {
                let info = (name: name, symbol: "")
                currencyInfo.append(info)
            }
        }
        return currencyInfo
    }
}
