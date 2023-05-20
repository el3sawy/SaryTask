//
//  HomeViewModel.swift
//  SaryTask
//
//  Created by Ahmed Naguib on 19/05/2023.
//

import Foundation
import RxSwift
import RxCocoa

final class HomeViewModel {
    
    // MARK: - Properties
    private let sliderUseCase: SliderUseCaseProtocol
    private let catalogUseCase: CatalogUseCaseProtocol
    private let disposeBag = DisposeBag()
    var homeSubject = BehaviorRelay<HomeState>(value: .showLoader)
    
    // MARK: - Init
    init(sliderUseCase: SliderUseCaseProtocol, catalogUseCase: CatalogUseCaseProtocol) {
        self.sliderUseCase = sliderUseCase
        self.catalogUseCase = catalogUseCase
    }
    
    // MARK: - Functions
    func viewDidLoad() {
        sliderUseCase.fetchSlider()
        catalogUseCase.fetchCatalog()
        handleOperators()
    }
    
    private func handleOperators() {
        Observable.zip(catalogUseCase.catalogObservable, sliderUseCase.imagesObservable)
            .subscribe(onNext: { [weak self] catalogs, banners in
                var homeModels: [any BaseHomeModelProtocol] = [banners]
                homeModels.append(contentsOf: catalogs)
                self?.homeSubject.accept(.success(data: homeModels))
                self?.homeSubject.accept(.hideLoader)
            }, onError: { error in
                let message = (error as? NetworkError)?.description
                self.homeSubject.accept(.error(message: message))
                self.homeSubject.accept(.hideLoader)
            })
            .disposed(by: disposeBag)
    }
}
