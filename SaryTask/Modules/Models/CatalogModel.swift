//
//  CatalogModel.swift
//  SaryTask
//
//  Created by Ahmed Naguib on 19/05/2023.
//

import Foundation

struct CatalogDataModel: BaseModel {
    var message: String?
    var status: Bool?
    var detail: String?
    let result: [CategoryModel]?
}

// MARK: - CategoryModel
struct CategoryModel: Codable {
    let id: Int?
   
    let title, subtitle: String?
    let data: [ProductModel]?
    let dataType: String?
    let showTitle: Bool?
    let uiType: String?
    let rowCount: Int?
    let showMoreEnabled: Bool?
    let displayPage: String?
 
    let groupID, itemsCount: Int?
    let isMustRefresh: Bool?

    enum CodingKeys: String, CodingKey {
        case id, title, subtitle, data
        case dataType = "data_type"
        case showTitle = "show_title"
        case uiType = "ui_type"
        case rowCount = "row_count"
        case showMoreEnabled = "show_more_enabled"
        case displayPage = "display_page"
       
        case groupID = "group_id"
        case itemsCount = "items_count"
        case isMustRefresh = "is_must_refresh"
    }
}

// MARK: - ProductModel
struct ProductModel: Codable {
    let groupID: Int?
    let name: String?
    let image: String?
    let visuals: Bool?
    let isMustRefresh: Bool?
    let deepLink: String?

    enum CodingKeys: String, CodingKey {
        case groupID = "group_id"
        case name, image, visuals
        case isMustRefresh = "is_must_refresh"
        case deepLink = "deep_link"
    }
}

