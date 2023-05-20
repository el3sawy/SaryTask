//
//  JsonParser.swift
//  SaryTask
//
//  Created by Ahmed Naguib on 19/05/2023.
//

import Foundation

protocol JsonParserProtocol {
    func parse<T: BaseModel>(data: Data)  -> Result<T, NetworkError>
}

struct JsonParser: JsonParserProtocol {
    func parse<T: BaseModel>(data: Data)  -> Result<T, NetworkError> {
        guard let model = try? JSONDecoder().decode(T.self, from: data) else {
            return .failure(.canNotDecode)
        }
        if model.isSuccess {
            return .success(model)
        } else {
            return .failure(.error(model.detail ?? ""))
        }
    }
}
