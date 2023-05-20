//
//  HomeRepository.swift
//  SaryTask
//
//  Created by Ahmed Naguib on 19/05/2023.
//

import Foundation
import RxSwift

protocol MainRepositoryProtocol {
    func fetchBanners() -> Observable<BannerDataModel>
    func fetchCatalog() -> Observable<CatalogDataModel>
}

final class MainRepository {
    // MARK: - Properties
    private let network: NetworkProtocol
    
    // MARK: - Init
    init(network: NetworkProtocol) {
        self.network = network
    }
}

extension MainRepository: MainRepositoryProtocol {
    func fetchBanners() -> Observable<BannerDataModel> {
        network.request(HomeRequests.banners)
    }
    
    func fetchCatalog() -> Observable<CatalogDataModel> {
        network.request(HomeRequests.catalogs)
    }
}
