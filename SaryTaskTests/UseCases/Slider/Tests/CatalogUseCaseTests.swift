//
//  CatalogUseCaseTests.swift
//  SaryTaskTests
//
//  Created by Ahmed Naguib on 20/05/2023.
//

import RxCocoa
import RxSwift
import RxTest
import XCTest
@testable import SaryTask

final class CatalogUseCaseTests: XCTestCase {

    // MARK: - Properties
    private var sut: CatalogUseCase!
    private var repository: MainRepositoryMock!
    private var disposeBag: DisposeBag!
    var scheduler: TestScheduler!
    
    override func setUpWithError() throws {
        repository = MainRepositoryMock()
        sut = CatalogUseCase(repository: repository)
        disposeBag = DisposeBag()
        scheduler = TestScheduler(initialClock: 0, resolution: 0.001)
    }

    override func tearDownWithError() throws {
        repository = nil
        sut = nil
        disposeBag = nil
        scheduler = nil
    }
    
    func test_fetchCatalog_successResponse() {
        // GIVEN
        let catalogs = CatalogStubs.getCatalogsUIModel()
        let uiModel = scheduler.createObserver([CatalogUIModel].self)
        
        // WHEN
        sut.catalogObservable.bind(to: uiModel).disposed(by: disposeBag)
        scheduler.scheduleAt(0, action: {
            self.sut.fetchCatalog()
        })
        scheduler.start()
        let streamValues: [Recorded<Event<[CatalogUIModel]>>]
        streamValues = [.next(0, catalogs),
                        .completed(0)]
     
        // THEN
        XCTAssertEqual(uiModel.events, streamValues)
    }
    
    func test_catalogUIModel_liner_rowHeight() {
        let height = CatalogStubs.getCatalogsUIModel().first?.rowHeight
        XCTAssertEqual(height, 140)
    }
    
    func test_catalogUIModel_grid_rowHeight() {
        // GIVEN
        let catalog = CatalogStubs.getCatalogUIModel()
        let height = catalog.rowHeight
        
        //THEN
        XCTAssertEqual(height, 420)
    }
}
