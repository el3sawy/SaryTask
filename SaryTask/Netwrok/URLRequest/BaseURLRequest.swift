//
//  BaseURLRequest.swift
//  SaryTask
//
//  Created by Ahmed Naguib on 18/05/2023.
//

import Foundation

protocol BaseURLRequest {
    var method: HttpMethod { get }
    var path: String { get }
    var baseUrl: String { get }
    func urlRequest() -> URLRequest
}

extension BaseURLRequest {
    var baseUrl: String {
        return DomainURL.production.path
    }
    
    func urlRequest() -> URLRequest {
        let baseURL = URL(string: baseUrl)!
        var urlRequest = URLRequest(url: baseURL.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        
        urlRequest.addValue(Constants.token, forHTTPHeaderField: "Authorization")
        urlRequest.addValue("7.7.0.0.0", forHTTPHeaderField: "App-Version")
        urlRequest.addValue("ar", forHTTPHeaderField: "Accept-Language")
        urlRequest.addValue("ios", forHTTPHeaderField: "Device-Type")
        return urlRequest
    }
}
