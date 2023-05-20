//
//  HomeSections.swift
//  SaryTask
//
//  Created by Ahmed Naguib on 19/05/2023.
//

import Foundation

enum HomeSections {
    case slider
    case catalog
}

enum CatalogTypeEnum: String {
    case grid
    case linear
}

protocol BaseHomeModelProtocol: Equatable {
    var homeSection: HomeSections { get set }
}

extension BaseHomeModelProtocol {
    static func == (lhs: any BaseHomeModelProtocol, rhs: any BaseHomeModelProtocol) -> Bool {
        return lhs.homeSection == rhs.homeSection
    }
}
