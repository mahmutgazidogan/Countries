//
//  DetailsInteractor.swift
//  Countries
//
//  Created by Mahmut Gazi Doğan on 19.01.2024.
//

import Foundation

class DetailsInteractor: DetailsPresenterToInteractorProtocol {
    var presenter: DetailsInteractorToPresenterProtocol?
    var details: Country?
    
    func getCountryDetails(countryDetails: Country?) {
        details = countryDetails
    }
    
    func giveDetails() -> Country? {
        if let png = details?.flags?.png?.replacingOccurrences(of: "w320", with: "w1280") {
            details?.flags?.png = png
        }
        return details
    }
    
    func numberFormatter(number: Double) -> String? {
        let minimumFractionDigits = 0
        let maximumFractionDigits = 0
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = minimumFractionDigits
        formatter.maximumFractionDigits = maximumFractionDigits
        let intValue = Int(number)
        return formatter.string(from: NSNumber(value: intValue))
    }
    
    func getAllCurrencyInfo(from currencies: Currencies) -> [(name: String, symbol: String)] {
        var currencyInfo: [(name: String, symbol: String)] = []
        let mirror = Mirror(reflecting: currencies)
        for child in mirror.children {
            if let currency = child.value as? Aed, let name = currency.name, let symbol = currency.symbol {
                let info = (name: name, symbol: symbol)
                currencyInfo.append(info)
            } else if let bamCurrency = child.value as? BAM, let name = bamCurrency.name {
                let info = (name: name, symbol: "")
                currencyInfo.append(info)
            }
        }
        return currencyInfo
    }
    
    func giveCurrency() -> String? {
        var string = ""
        if let details, let currencies = details.currencies {
            let allCurrencies = getAllCurrencyInfo(from: currencies)
            for currency in allCurrencies {
                string = "\(currency.name) (\(currency.symbol))"
            }
        }
        return string
    }
    
}
