//
//  SliderUseCaseTests.swift
//  SaryTaskTests
//
//  Created by Ahmed Naguib on 20/05/2023.
//

import RxCocoa
import RxSwift
import RxTest
import XCTest
@testable import SaryTask

final class SliderUseCaseTests: XCTestCase {
    
    // MARK: - Properties
    private var sut: SliderUseCase!
    private var repository: MainRepositoryMock!
    private var disposeBag: DisposeBag!
    var scheduler: TestScheduler!
    
    override func setUpWithError() throws {
        repository = MainRepositoryMock()
        sut = SliderUseCase(repository: repository)
        disposeBag = DisposeBag()
        scheduler = TestScheduler(initialClock: 0, resolution: 0.001)
    }

    override func tearDownWithError() throws {
        repository = nil
        sut = nil
        disposeBag = nil
        scheduler = nil
    }
    
    func test_fetchSlider_successResponse() {
        // GIVEN
        let bannerModel = CatalogStubs.getSliderUIModel()
        let uiModel = scheduler.createObserver(SliderUIModel.self)
        
        // WHEN
        sut.imagesObservable.bind(to: uiModel).disposed(by: disposeBag)
        scheduler.scheduleAt(0, action: {
            self.sut.fetchSlider()
        })
        scheduler.start()
        let streamValues: [Recorded<Event<SliderUIModel>>]
        streamValues = [.next(0, bannerModel),
                        .completed(0)]
     
        // THEN
        XCTAssertEqual(uiModel.events, streamValues)
    }
}
