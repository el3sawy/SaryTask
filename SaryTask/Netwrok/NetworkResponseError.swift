//
//  NetworkResponseError.swift
//  SaryTask
//
//  Created by Ahmed Naguib on 19/05/2023.
//

import Foundation

protocol ResponseErrorProtocol {
    func filter(error: Error) -> NetworkError
}

struct NetworkResponseError: ResponseErrorProtocol {
    func filter(error: Error) -> NetworkError {
        if let error =  error as NSError?, error.code == -1009 {
            return .noInternet
        } else {
            return NetworkError.error(error.localizedDescription)
        }
    }
}
