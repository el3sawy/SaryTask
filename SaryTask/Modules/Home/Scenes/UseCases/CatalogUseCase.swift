//
//  CatalogUseCase.swift
//  SaryTask
//
//  Created by Ahmed Naguib on 19/05/2023.
//

import Foundation
import RxSwift

protocol CatalogUseCaseProtocol {
    func fetchCatalog()
    var catalogObservable: Observable<[CatalogUIModel]> { get }
}

final class CatalogUseCase {
    // MARK: - Properties
    private let repository: MainRepositoryProtocol
    private let disposeBag = DisposeBag()
    var catalogSubject = PublishSubject<[CatalogUIModel]>()
    private let bannerDataType = "banner"
    var catalogObservable: Observable<[CatalogUIModel]> {
        catalogSubject.asObserver()
    }
    
    // MARK: - Init
    init(repository: MainRepositoryProtocol) {
        self.repository = repository
    }
}

// MARK: - Extension 
extension CatalogUseCase: CatalogUseCaseProtocol {
    func fetchCatalog() {
        repository.fetchCatalog()
            .subscribe(onNext: { [weak self] response in
                guard let self = self else {
                    return
                }
                let categories = response.result ?? []
                let models = self.mapper(categories: categories)
                self.catalogSubject.onNext(models)
                self.catalogSubject.onCompleted()
            }, onError: { error in
                self.catalogSubject.onError(error)
            })
            .disposed(by: disposeBag)
    }
    
    private func mapper(categories: [CategoryModel]) -> [CatalogUIModel] {
        let catalogs = categories.filter({ $0.dataType == bannerDataType })
        let filteredCatalogs = catalogs.map(mapCategories)
        return filteredCatalogs
    }
    
    private func mapCategories(_ category: CategoryModel) -> CatalogUIModel  {
        let title = category.title
        let isShowTitle = category.showTitle ?? false
        let type = category.uiType ?? ""
        let rowCount = category.rowCount ?? 0
        let products = category.data ?? []
        let productsModel = mapProducts(products)
        
        return .init(title: title,
                     products: productsModel,
                     showTitle: isShowTitle,
                     uiType: type,
                     rowCount: rowCount)
    }
    
    private func mapProducts(_ products: [ProductModel]) -> [ProductUIModel] {
        products.map(mapProduct)
    }
    
    private func mapProduct(product: ProductModel) -> ProductUIModel {
        .init(image: product.image, name: product.name)
    }
}
