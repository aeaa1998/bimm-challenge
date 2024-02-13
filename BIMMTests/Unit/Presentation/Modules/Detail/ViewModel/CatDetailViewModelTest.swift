//
//  CatDetailViewModel.swift
//  BIMMTests
//
//  Created by Augusto Alonso on 9/02/24.
//

import XCTest
import Combine
@testable import BIMM

final class CatDetailViewModelTest : XCTestCase {
    private var catDetailViewModel : CatDetailViewModel!
    private var fakeCatService : FakeCatService!
    private var cancellables: [AnyCancellable] = []
    
    override func setUpWithError() throws {
        //Setup for each test an isolated instance
        fakeCatService = .init()
        catDetailViewModel = .init(catService: fakeCatService)
    }
    
    
    func test_fetchCat_shouldSetFailedState() async {
        //Arrange
        fakeCatService.scenario = .failure
        let requesStateEnteredLoadingState = XCTestExpectation(description: "Request state entered loading state")
        catDetailViewModel.$requestState
            .dropFirst()
            .first()
            .sink { state in
                if state == .loading {
                    requesStateEnteredLoadingState.fulfill()
                }
            }
            .store(in: &cancellables)
        
        //Act
        await catDetailViewModel.fetchCat(for: .init(id: "cat", tags: [], owner: nil))
        
        //Assert
        await fulfillment(of: [requesStateEnteredLoadingState], timeout: 2)
        XCTAssertEqual(catDetailViewModel.requestState, RequestState.error())
        XCTAssertNil(catDetailViewModel.cat)
    }
    
    func test_fetchCat_shouldSetSucessState() async throws {
        //Arrange
        let expectedCat = FakeCatService.catDetail
        fakeCatService.scenario = .success
        
        //Act
        await catDetailViewModel.fetchCat(for: .init(id: "cat", tags: [], owner: nil))
        
        //Assert
        XCTAssertEqual(catDetailViewModel.requestState, RequestState.success)
        let cat = try XCTUnwrap(catDetailViewModel.cat)
        XCTAssertEqual(expectedCat, cat)
    }
}
