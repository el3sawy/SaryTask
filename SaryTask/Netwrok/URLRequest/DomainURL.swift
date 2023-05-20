//
//  DomainURL.swift
//  SaryTask
//
//  Created by Ahmed Naguib on 18/05/2023.
//

import Foundation

enum DomainURL {
    
    case production
    
    var path: String {
        switch self {
        case .production:
            return "https://staging.sary.to/api/baskets/328594/"
        }
    }
}

struct Constants {
    static let token = "token eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NDQyOTIsInVzZXJfcGhvbmUiOiIyMDEwNjQ5ODkyNTAifQ.zNhafprWylIawDsPfGjnkxh3icOV-XN-HgMD3uiXaG0"
}
