//
//  BannerUseCase.swift
//  SaryTask
//
//  Created by Ahmed Naguib on 19/05/2023.
//

import Foundation
import RxSwift

protocol SliderUseCaseProtocol {
    func fetchSlider()
    var imagesObservable: Observable<SliderUIModel> { get }
}

final class SliderUseCase {
    // MARK: - Properties
    private let repository: MainRepositoryProtocol
    private let disposeBag = DisposeBag()
    private var imagesSubject = PublishSubject<SliderUIModel>()
    
    var imagesObservable: Observable<SliderUIModel> {
        imagesSubject.asObservable()
    }
    // MARK: - Init
    init(repository: MainRepositoryProtocol) {
        self.repository = repository
    }
}

// MARK: - Extension
extension SliderUseCase: SliderUseCaseProtocol {
    func fetchSlider() {
        
        repository.fetchBanners()
            .subscribe(onNext: { [weak self] response in
                guard let self = self else {
                    return
                }
                let images = response.result?.map({ $0.image ?? "" }) ?? []
                let model = SliderUIModel(images: images)
                self.imagesSubject.onNext(model)
                self.imagesSubject.onCompleted()
                
            }, onError: { error in
                self.imagesSubject.onError(error)
            })
            .disposed(by: disposeBag)
    }
}
