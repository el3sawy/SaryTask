//
//  SliderUseCaseMoack.swift
//  SaryTaskTests
//
//  Created by Ahmed Naguib on 20/05/2023.
//

import Foundation
import RxSwift
@testable import SaryTask

final class SliderUseCaseMock {
    // MARK: - Properties
    var isCalledFetchSlider = false
}

extension SliderUseCaseMock: SliderUseCaseProtocol {
    func fetchSlider() {
        isCalledFetchSlider.toggle()
    }
    
    var imagesObservable: Observable<SliderUIModel> {
        Observable.just(CatalogStubs.getSliderUIModel())
    }
}
