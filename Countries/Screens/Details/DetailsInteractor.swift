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
        let sign = returnSign(details: details)
        let side = returnSide(details: details)
        let flagDescription = returnFlagDescription(details: details)
        let languages = returnLanguages(details: details)
        let timezone = returnTimezones(timezones: timezones)
        let independency = returnIndependencyImage(details: details)
        
        let countryCode = returnCountryCode(details: details)
        
        let coordinates = returnCoordinates(details: details)
        let latitude = coordinates.latitude
        let longitude = coordinates.longitude
        
        presenter.getDetails(name: name, capital: capital, area: areaValue,
                             population: numberOfPopulation, startOfWeek: startOfWeek,
                             currency: currency, timezones: timezone,
                             flag: flag, flagDescription: flagDescription,
                             languages: languages, sign: sign, side: side,
                             independency: independency, latitude: latitude, longitude: longitude)
    }

    private func returnCapital(details: Country) -> String {
        
//        if let capitals = details.capital {
//            for capital in capitals {
//                return capital.uppercased()
//            }
//            return "No capital data found!"
//        } else {
//            return "No capital data found!"
//        }
        
        if let capital = details.capital?.joined(separator: ", ") {
            return capital.uppercased()
        } else {
            return "No data found!"
        }
    }

    private func returnIndependencyImage(details: Country) -> String {
        if let independent = details.independent {
            if independent {
                return "Independent"
            } else {
                return "Not Independent"
            }
        } else {
            return "Independent"
        }
    }

    private func returnSign(details: Country) -> String {
        if let sign = details.car?.signs?.first {
            if sign == "" {
                return "No data found!"
            } else {
                return sign
            }
        }
        return "No data found!"
    }
    
    private func returnSide(details: Country) -> String {
        if let side = details.car?.side?.rawValue.capitalized {
            if side == "" {
                return side
            } else {
                return side
            }
        }
        return "No data found!"
    }

    private func returnFlagDescription(details: Country) -> String {
        if let description = details.flags?.alt {
            return description
        } else {
            return "No description found!"
        }
    }

    private func returnLanguages(details: Country) -> String {
        if let languages = details.languages {
            let languageNames = languages.map({ (_, language) in
                language
            }).joined(separator: ", ")
            return languageNames
        } else {
            return "No data found!"
        }
    }

    private func returnTimezones(timezones: [String]) -> String {
        return timezones.joined(separator: ", ")
    }

    private func numberFormatter(number: Double) -> String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        let intValue = Int(number)
        return formatter.string(from: NSNumber(value: intValue))
    }

    private func returnCoordinates(details: Country) -> (latitude: Double, longitude: Double) {
        guard let capitalInfo = details.capitalInfo,
              let latitude = capitalInfo.latlng?.first,
              let longitude = capitalInfo.latlng?.last
        else {
            guard let latitude = details.latlng?.first,
                  let longitude = details.latlng?.last
            else { return (0, 0)}
            return (latitude, longitude)
        }
        return (latitude, longitude)
    }
    
    private func returnCountryCode(details: Country) -> String {
        if let idd = details.idd,
           let root = idd.root,
           let suffixes = idd.suffixes {
            for suffix in suffixes {
                if root == "+1" {
                    return "\(root)-\(suffix)"
                } else {
                    return "\(root)\(suffix)"
                }
            }
            return "No data found!"
        } else {
            return "No data found!"
        }
    }

    // MARK: Currency Functions
    private func getAllCurrencyInfo(from currencies: Currencies) -> [(name: String, symbol: String)] {
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
            string = "No data found!"
        }
        return string
    }
        
}
