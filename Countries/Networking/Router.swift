//
//  Router.swift
//  Countries
//
//  Created by Mahmut Gazi Doğan on 4.11.2023.
//

import Foundation
import Alamofire

public enum Router: URLRequestConvertible {
    
    case allCountries
    
    var baseURL: URL {
        guard let url = URL(string: "https://restcountries.com") else {
            fatalError("Failed to create URL.")
        }
        return url
    }
    
    private var method: HTTPMethod {
        switch self {
        case .allCountries:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .allCountries:
            return "/v3.1/all"
        }
    }
    
    private var parameters: Parameters {
        switch self {
        case .allCountries:
            return [:]
        }
    }
    
    private var headers: HTTPHeaders {
        switch self {
        case .allCountries:
            return [:]
        }
    }
    
    public func asURLRequest() throws -> URLRequest {
        let url = try baseURL.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        urlRequest.headers = headers
        print(url)
        
        let encoding: ParameterEncoding = {
        switch method {
        case .get:
            return URLEncoding.default
        default:
            return JSONEncoding.default
        }
    }()
    return try encoding.encode(urlRequest, with: parameters)
    }
}
