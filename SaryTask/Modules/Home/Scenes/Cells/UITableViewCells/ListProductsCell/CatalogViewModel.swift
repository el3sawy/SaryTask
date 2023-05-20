//
//  CatalogViewModel.swift
//  SaryTask
//
//  Created by Ahmed Naguib on 19/05/2023.
//

import Foundation


struct CatalogUIModel: BaseHomeModelProtocol {
    
    var homeSection: HomeSections = .catalog
    var title: String?
    var products: [ProductUIModel]
    var showTitle: Bool = false
    var uiType: String = ""
    var rowCount: Int = 0
    let productCellHeight = 140
    
    var collectionViewType: CatalogTypeEnum {
        uiType == CatalogTypeEnum.grid.rawValue ? .grid : .linear
    }
    
    var rowHeight: Int {
        guard collectionViewType == .grid else {
            return productCellHeight
        }
        
        let countOfProducts = products.count
        let rowsCount = countOfProducts / rowCount
        let remming = countOfProducts % rowCount
        let totalRows  = (remming + rowsCount)
        let sectionHeight = totalRows * productCellHeight
        return countOfProducts > rowCount ? sectionHeight : productCellHeight
    }
}

extension CatalogUIModel: Equatable {
    static func == (lhs: CatalogUIModel, rhs: CatalogUIModel) -> Bool {
        lhs.showTitle == rhs.showTitle && lhs.products.count == rhs.products.count
    }
}

struct ProductUIModel {
    let image: String?
    let name: String?
}
