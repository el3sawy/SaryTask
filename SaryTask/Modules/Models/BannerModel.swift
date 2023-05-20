//
//  BannerModel.swift
//  SaryTask
//
//  Created by Ahmed Naguib on 19/05/2023.
//

import Foundation

struct BannerDataModel: BaseModel {
    var detail: String?
    var message: String?
    var status: Bool?
    let result: [BannerModel]?
}

// MARK: - Result
struct BannerModel: Codable {
   
    let id: Int?
    let title, description, buttonText: String?
    let expiryStatus: Bool?
    let createdAt, startDate, expiryDate: String?
    let image, photo: String?
    let promoCode: String?
    let isAvailable: Bool?
    let priority: Int?
    
    let level: String?
    

    enum CodingKeys: String, CodingKey {
        case id, title, description
        case buttonText = "button_text"
        case expiryStatus = "expiry_status"
        case createdAt = "created_at"
        case startDate = "start_date"
        case expiryDate = "expiry_date"
        case image, photo
        case promoCode = "promo_code"
        case isAvailable = "is_available"
        case priority, level
    }
}
