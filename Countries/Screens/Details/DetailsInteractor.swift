//
//  DetailsInteractor.swift
//  Countries
//
//  Created by Mahmut Gazi Doğan on 19.01.2024.
//

import UIKit

final class DetailsInteractor: DetailsPresenterToInteractorProtocol {
    var presenter: DetailsInteractorToPresenterProtocol?
    var details: Country?
    
    // MARK: Detail Datas Functions
    func giveDetails() {
        
        guard let presenter,
              let details,
              let name = details.name?.official?.uppercased(),
              let flag = details.flags?.png,
              let area = details.area,
              let areaValue = numberFormatter(number: area),
              let population = details.population,
              let numberOfPopulation = numberFormatter(number: Double(population)),
              let startOfWeek = details.startOfWeek?.rawValue.capitalized,
              let currency = giveCurrency(),
              let timezones = details.timezones else { return }
        let capital = returnCapital(details: details)
        let carDetails = returnCarDetails(details: details)
        let flagDescription = returnFlagDescription(details: details)
        let languages = returnLanguages(details: details)
        let timezone = returnTimezones(timezones: timezones)
        let independency = returnIndependencyImage(details: details)
        
        presenter.getDetails(name: name, capital: capital, area: areaValue,
                          population: numberOfPopulation, startOfWeek: startOfWeek,
                          currency: currency, timezones: timezone,
                          flag: flag, flagDescription: flagDescription,
                          languages: languages, carDetails: carDetails, independency: independency)
    }
    
    private func returnCapital(details: Country) -> String {
        if let capital = details.capital?.first {
            return capital
        } else {
            return "No capital data found!"
        }
    }
    
    private func returnIndependencyImage(details: Country) -> UIImage? {
        if let independent = details.independent {
            if independent {
                return Icons.tick.image
            } else {
                return Icons.cross.image
            }
        } else {
            return Icons.tick.image
        }
    }
    
    private func returnCarDetails(details: Country) -> String {
        if let sign = details.car?.signs?.first,
           let side = details.car?.side?.rawValue.capitalized {
            if sign == "" {
                return "Car Sign: No sign data found!\nCar Side: \(side)"
            } else {
                return "Car Sign: \(sign)\nCar Side: \(side)"
            }
        }
        return "No car data found!"
    }
    
    private func returnFlagDescription(details: Country) -> String {
        if let description = details.flags?.alt {
            return description
        } else {
            return "No flag description found!"
        }
    }
    
    private func returnLanguages(details: Country) -> String {
        if let languages = details.languages {
            let languageNames = languages.map({ (_, language) in
                language
            }).joined(separator: ", ")
            return "Languages: \(languageNames)"
        } else {
            return "Languages: No languages data found!"
        }
    }
    
    private func returnTimezones(timezones: [String]) -> String {
        return timezones.joined(separator: ", ")
    }
    
    private func numberFormatter(number: Double) -> String? {
        let minimumFractionDigits = 0
        let maximumFractionDigits = 0
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = minimumFractionDigits
        formatter.maximumFractionDigits = maximumFractionDigits
        let intValue = Int(number)
        return formatter.string(from: NSNumber(value: intValue))
    }
    
    // MARK: Currency Functions
    func getAllCurrencyInfo(from currencies: Currencies) -> [(name: String, symbol: String)] {
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
    
    private func giveCurrency() -> String? {
        var string = ""
        if let details,
           let currencies = details.currencies {
            let allCurrencies = getAllCurrencyInfo(from: currencies)
            for (index, currency) in allCurrencies.enumerated() {
                string += "\(currency.name.capitalized) (\(currency.symbol.capitalized))"
                if index < allCurrencies.count - 1 {
                    string += ", "
                }
            }
        } else {
            string = "No currency data found!"
        }
        return string
    }
    
}

