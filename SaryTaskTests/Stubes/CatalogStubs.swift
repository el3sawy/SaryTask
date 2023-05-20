//
//  CatalogStubs.swift
//  SaryTaskTests
//
//  Created by Ahmed Naguib on 20/05/2023.
//

import Foundation
@testable import SaryTask

enum CatalogStubs {
    static func createBannersModel() -> BannerDataModel {
        let data = getJSON(bundle: Bundle.testBundle, for: "Banner_Response")
        let banners: BannerDataModel? = parse(jsonData: data)
        return banners ?? .init(result: [])
    }
    
    static func createCatalogModel() -> CatalogDataModel {
        let data = getJSON(bundle: Bundle.testBundle, for: "Catalog_Response")
        let banners: CatalogDataModel? = parse(jsonData: data)
        return banners ?? .init(result: [])
    }
    
    private static func parse<T: Codable>(jsonData: Data) -> T? {
        do {
            let decodedData = try JSONDecoder().decode(T.self, from: jsonData)
            return decodedData
        } catch {
            print("decode error")
        }
        return nil
    }
    
    static func getSliderUIModel() -> SliderUIModel {
        let image = "https://testing-sary.imgix.net/banners/ar/2022/08/Flash_Offer_-_F2211A_-15_Mar_MAD_Announcement_ENG.png"
        return SliderUIModel(images: [image])
    }
    
    static func getCatalogsUIModel() -> [CatalogUIModel] {
        let products: [ProductUIModel] = [
            .init(image: "https://testing-sary.imgix.net/%D8%A8%D9%82%D8%A7%D9%84%D8%A9_BV8aGKm.png", name: nil),
            .init(image: "https://testing-sary.imgix.net/%D9%85%D8%A7%D9%83%D9%88%D9%84%D8%A7%D8%AA_%D8%A7%D8%B3%D8%A7%D8%B3%D9%8A%D8%A9_3lGyQKg.png", name: nil)
        ]
        
        let catalog = CatalogUIModel(homeSection: .catalog, products: products, showTitle: true, uiType: "linear", rowCount: 3)
        return [catalog]
    }
    
    static func getCatalogUIModel() -> CatalogUIModel {
        let products: [ProductUIModel] = [
            .init(image: "image1", name: nil),
            .init(image: "image2", name: nil),
            .init(image: "image3", name: nil),
            .init(image: "image4", name: nil),
            .init(image: "image5", name: nil),
            .init(image: "image6", name: nil),
            .init(image: "image7", name: nil),
        ]
        
        let catalog = CatalogUIModel(homeSection: .catalog, products: products, showTitle: true, uiType: "grid", rowCount: 3)
        return catalog
    }
}
