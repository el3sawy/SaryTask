//
//  HomeRequests.swift
//  SaryTask
//
//  Created by Ahmed Naguib on 19/05/2023.
//

import Foundation

enum HomeRequests: BaseURLRequest {
    case banners
    case catalogs
    
    var method: HttpMethod {
        .get
    }
    
    var path: String {
        switch self {
            
        case .banners:
            return "banners/"
        case .catalogs:
            return "catalog/"
        }
    }
}
