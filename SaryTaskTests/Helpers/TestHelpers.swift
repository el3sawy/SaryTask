//
//  v.swift
//  SaryTaskTests
//
//  Created by Ahmed Naguib on 20/05/2023.
//

import Foundation
import XCTest

extension Bundle {
    public class var testBundle: Bundle {
        return Bundle(for: SliderUseCaseTests.self)
    }
}

// MARK: - helpers
func getJSON(bundle: Bundle, for jsonName: String) -> Data {
    guard let path = bundle.path(forResource: jsonName, ofType: "json") else {
        fatalError("Could not retrieve file \(jsonName).json")
    }
    let url = URL(fileURLWithPath: path)
    let data = try! Data(contentsOf: url)
    return data
}
