//
//  MainRepositoryMock.swift
//  SaryTaskTests
//
//  Created by Ahmed Naguib on 20/05/2023.
//

import Foundation
import RxSwift
@testable import SaryTask

final class MainRepositoryMock: MainRepositoryProtocol {
    
    func fetchBanners() -> Observable<BannerDataModel> {
        Observable.just(CatalogStubs.createBannersModel())
    }
    
    func fetchCatalog() -> Observable<CatalogDataModel> {
        Observable.just(CatalogStubs.createCatalogModel())
    }
}
