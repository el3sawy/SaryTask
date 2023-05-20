//
//  BaseModel.swift
//  SaryTask
//
//  Created by Ahmed Naguib on 19/05/2023.
//

import Foundation

protocol BaseModel: Codable {
    var message: String? { get set }
    var status: Bool? { get set }
    var detail: String? { get set }
}

extension BaseModel {
    var isSuccess: Bool {
        (status ?? false) == true
    }
}
