//
//  CatalogUseCaseMock.swift
//  SaryTaskTests
//
//  Created by Ahmed Naguib on 20/05/2023.
//

import Foundation
import RxSwift
@testable import SaryTask

final class CatalogUseCaseMock {
    
    // MARK: - Properties
    var isCalledFetchCatalog = false
    private var catalogSubject =  PublishSubject<[CatalogUIModel]>()
    // MARK: - Functions
    func simulateSuccessResponse() {
        catalogSubject.onNext(CatalogStubs.getCatalogsUIModel())
    }
    
    func simulateFailResponse() {
        catalogSubject.onError(NetworkError.canNotDecode)
        catalogSubject.onCompleted()
    }
}

extension CatalogUseCaseMock: CatalogUseCaseProtocol {
    func fetchCatalog() {
        isCalledFetchCatalog.toggle()
    }
    
    var catalogObservable: Observable<[CatalogUIModel]> {
        catalogSubject.asObservable()
    }
}
