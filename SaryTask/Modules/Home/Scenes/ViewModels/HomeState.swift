//
//  HomeState.swift
//  SaryTask
//
//  Created by Ahmed Naguib on 20/05/2023.
//

import Foundation

enum HomeState: Equatable {
    case showLoader
    case hideLoader
    case error(message: String?)
    case success(data: [any BaseHomeModelProtocol])
    
    static func == (lhs: HomeState, rhs: HomeState) -> Bool {
        switch(lhs, rhs) {
        case (.showLoader, .showLoader):
            return true
        case (.hideLoader, .hideLoader):
            return true
        case (.error(let lhsMessage), .error(let rhsMessage)):
            return lhsMessage == rhsMessage
        default:
            return true
       
        }
    }
}
