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
    
}
