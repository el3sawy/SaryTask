//
//  HomeViewModelTests.swift
//  SaryTaskTests
//
//  Created by Ahmed Naguib on 20/05/2023.
//

import RxCocoa
import RxSwift
import RxTest
import XCTest
@testable import SaryTask

final class HomeViewModelTests: XCTestCase {
    
    // MARK: - Properties
    private var sut: HomeViewModel!
    private var catalogUseCase: CatalogUseCaseMock!
    private var sliderUseCase: SliderUseCaseMock!
    private var disposeBag: DisposeBag!
    var scheduler: TestScheduler!
    
    override func setUpWithError() throws {
        catalogUseCase =  CatalogUseCaseMock()
        sliderUseCase = SliderUseCaseMock()
        sut = HomeViewModel(sliderUseCase: sliderUseCase, catalogUseCase: catalogUseCase)
        disposeBag = DisposeBag()
        scheduler = TestScheduler(initialClock: 0, resolution: 0.001)
    }
    
    override func tearDownWithError() throws {
        catalogUseCase = nil
        sliderUseCase = nil
        sut = nil
        disposeBag = nil
        scheduler = nil
    }
    
    func test_viewDidLoad_check_call_useCase_correct() {
        // WHEN
        sut.viewDidLoad()
        // THEN
        XCTAssertTrue(sliderUseCase.isCalledFetchSlider)
        XCTAssertTrue(catalogUseCase.isCalledFetchCatalog)
    }
    
    
    func test_handleOperators_check_bind_to_view_correct() {
        // GIVEN
        let sliderModel = CatalogStubs.getSliderUIModel()
        let catalogModels = CatalogStubs.getCatalogsUIModel()
        var homeModels: [any BaseHomeModelProtocol] = [sliderModel]
        homeModels.append(contentsOf: catalogModels)
        let uiSubject = scheduler.createObserver(HomeState.self)
        
        // WHEN
        sut.homeSubject.bind(to: uiSubject).disposed(by: disposeBag)
        scheduler.scheduleAt(0, action: {
            self.sut.viewDidLoad()
            self.catalogUseCase.simulateSuccessResponse()
        })
        scheduler.start()
        let streamValues: [Recorded<Event<HomeState>>]
        streamValues = [
            .next(0, .showLoader),
            .next(0, .success(data: homeModels)),
            .next(0, .hideLoader)
        ]
     
        // THEN
        XCTAssertEqual(uiSubject.events, streamValues)
    }
    
    func test_handleOperators_check_bind_to_view_showErrorMessage() {
        // GIVEN
        let uiSubject = scheduler.createObserver(HomeState.self)
        
        // WHEN
        sut.homeSubject.bind(to: uiSubject).disposed(by: disposeBag)
        scheduler.scheduleAt(0, action: {
            self.sut.viewDidLoad()
            self.catalogUseCase.simulateFailResponse()
        })
        scheduler.start()
        let streamValues: [Recorded<Event<HomeState>>]
        streamValues = [
            .next(0, .showLoader),
            .next(0, .error(message: NetworkError.canNotDecode.description)),
            .next(0, .hideLoader)
        ]
     
        // THEN
        XCTAssertEqual(uiSubject.events, streamValues)
    }
}
