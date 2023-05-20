//
//  NetworkError.swift
//  SaryTask
//
//  Created by Ahmed Naguib on 19/05/2023.
//

import Foundation

enum NetworkError: Error, LocalizedError, Equatable {
    case canNotDecode
    case noInternet
    case error(String)
    
    var description: String {
        switch self {
        case .canNotDecode:
            return Messages.cantDecode.rawValue
        case .noInternet:
            return Messages.noInternet.rawValue
        case let .error(custom):
            return custom
        }
    }
}
