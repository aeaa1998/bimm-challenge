//
//  CatHomeViewModelTest.swift
//  BIMMTests
//
//  Created by Augusto Alonso on 9/02/24.
//


import XCTest
import Combine
@testable import BIMM

final class CatHomeViewModelTest : XCTestCase {
    private var catHomeViewModel : CatHomeViewModel!
    private var fakeCatService : FakeCatService!
    private var cancellables: [AnyCancellable] = []
    
    override func setUpWithError() throws {
        //Setup for each test an isolated instance
        fakeCatService = .init()
        catHomeViewModel = .init(catService: fakeCatService)
    }
    
    
    func test_fetchCats_shouldSetFailedState() async {
        //Arrange
        fakeCatService.scenario = .failure
        let requesStateEnteredLoadingState = XCTestExpectation(description: "Request state entered loading state")
        catHomeViewModel.$requestState
            .dropFirst()
            .first()
            .sink { state in
                if state == .loading {
                    requesStateEnteredLoadingState.fulfill()
                }
            }
            .store(in: &cancellables)
        
        //Act
        await catHomeViewModel.fetchCats()
        
        //Assert
        await fulfillment(of: [requesStateEnteredLoadingState], timeout: 2)
        XCTAssertEqual(catHomeViewModel.requestState, RequestState.error())
        XCTAssertTrue(catHomeViewModel.cats.isEmpty)
    }
    
    func test_fetchCats_shouldSetSucessState() async throws {
        //Arrange
        let expectedCats = FakeCatService.catsList
        fakeCatService.scenario = .success
        
        //Act
        await catHomeViewModel.fetchCats()
        
        //Assert
        XCTAssertEqual(catHomeViewModel.requestState, RequestState.success)
        XCTAssertFalse(catHomeViewModel.cats.isEmpty)
        XCTAssertEqual(expectedCats, catHomeViewModel.cats)
    }
    
    
    func test_fetchCats_shouldSetEmptyState() async throws {
        //Arrange
        fakeCatService.scenario = .empty
        
        //Act
        await catHomeViewModel.fetchCats()
        
        //Assert
        XCTAssertEqual(catHomeViewModel.requestState, RequestState.success)
        XCTAssertTrue(catHomeViewModel.cats.isEmpty)
    }
}
