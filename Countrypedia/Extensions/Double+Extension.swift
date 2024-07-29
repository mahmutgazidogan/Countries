//
//  Double + Extension.swift
//  Countries
//
//  Created by Mahmut Doğan on 20.06.2024.
//

import Foundation

// MARK: Double Extension

extension Double {
    static func returnCoordinates(details: Country) -> (latitude: Double, longitude: Double) {
        if let capitalInfo = details.capitalInfo,
           let latitude = capitalInfo.latlng?.first,
           let longitude = capitalInfo.latlng?.last {
            return (latitude, longitude)
        } else if let latitude = details.latlng?.first,
                  let longitude = details.latlng?.last {
            return (latitude, longitude)
        } else {
            return (0, 0)
        }
    }
}
