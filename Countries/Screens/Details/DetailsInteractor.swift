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
        print(details)
    }
}
