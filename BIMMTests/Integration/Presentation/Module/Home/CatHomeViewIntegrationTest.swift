//
//  CatHomeViewIntegrationTest.swift
//  BIMMTests
//
//  Created by Augusto Alonso on 9/02/24.
//

import XCTest
import SwiftUI
import ViewInspector
import Combine
@testable import BIMM

final class CatHomeViewIntegrationTest: XCTestCase {

    private var catHomeViewModel : CatHomeViewModel!
    private var fakeCatService : FakeCatService!
    private var cancellables: [AnyCancellable] = []
    
    override func setUpWithError() throws {
        //Setup for each test an isolated instance
        fakeCatService = .init()
        catHomeViewModel = .init(catService: fakeCatService)
    }

    func test_emptyState_CatHomeView_Content() throws {
        //Arrange
        let view = CatHomeView.Content(requestState: .success, tagsRequestState: .success, cats: [], filterTags: [], filtersVisible: .constant(false), onCatSelected: { _ in }, onRetry: {})
        
        //Assert
        let emptyText = try? XCTUnwrap(try? view.inspect().find(ViewType.Text.self){ text in
            try text.string() == String(localized: "no_cats_found")
        })
        
        
        XCTAssertNil(try? view.inspect().find(CatCardView.self))
        
    }

    
    func test_errorState_CatHomeView_Content() throws {
        //Arrange
        let view = CatHomeView.Content(requestState: .error("error"), tagsRequestState: .success, cats: [], filterTags: [], filtersVisible: .constant(false), onCatSelected: { _ in }, onRetry: {})
        
        //Assert
        _ = try? XCTUnwrap(try? view.inspect().find(SadCatErrorView.self))
        XCTAssertNil(try? view.inspect().find(CatCardView.self))
    }
    
    
    func test_successState_CatHomeView_Content() throws {
        //Arrange
        let cats = FakeCatService.catsList
        let view = CatHomeView.Content(requestState: .success, tagsRequestState: .success, cats: cats, filterTags: [], filtersVisible: .constant(false), onCatSelected: { _ in }, onRetry: {})
        
        //Assert
        
        XCTAssertNil(try? view.inspect().find(SadCatErrorView.self))
        XCTAssertNil(try? view.inspect().find(ViewType.Text.self){ text in
            try text.string() == String(localized: "no_cats_found")
        })
        
        let cards = try view.inspect().findAll(CatCardView.self)
        
        XCTAssertEqual(cards.count, cats.count)
                     
    }
    
    
    func test_successFilters_CatHomeView_Content() throws {
        //Arrange
        let cats = FakeCatService.catsList
        let view = CatHomeView.Content(requestState: .success, tagsRequestState: .success, cats: cats, filterTags: ["tag2"], filtersVisible: .constant(false), onCatSelected: { _ in }, onRetry: {})
        
        //Assert
        
        let cards = try view.inspect().findAll(CatCardView.self)
        XCTAssertEqual(cards.count, 1)
                     
    }
    
    func test_successScenario_viewModel_CatHomeView() throws {
        //Arrange
        fakeCatService.scenario = .success
        let cats = FakeCatService.catsList
        let view = CatHomeView(catHomeViewModel: self.catHomeViewModel).environmentObject(Router<CataasNavigation>())
        let expectation = expectation(description: "Request state is success")
        catHomeViewModel.$requestState.sink { state in
            if state == RequestState.success {
                expectation.fulfill()
            }
        }
        .store(in: &cancellables)
        
        //Act
        ViewHosting.host(view: view)
        
        //Assert
        wait(for: [expectation], timeout: 3)
        let cards = try view.inspect().findAll(CatCardView.self)
        XCTAssertEqual(cards.count, cats.count)
                     
    }
    
    
    func test_emptyScenario_viewModel_CatHomeView() throws {
        //Arrange
        fakeCatService.scenario = .empty
        let view = CatHomeView(catHomeViewModel: self.catHomeViewModel).environmentObject(Router<CataasNavigation>())
        let expectation = expectation(description: "Request state is success")
        catHomeViewModel.$requestState.sink { state in
            if state == RequestState.success {
                expectation.fulfill()
            }
        }
        .store(in: &cancellables)
        
        //Act
        ViewHosting.host(view: view)
        
        //Assert
        wait(for: [expectation], timeout: 3)
        let cards = try view.inspect().findAll(CatCardView.self)
        XCTAssertEqual(cards.count, 0)
        _ = try XCTUnwrap(try? view.inspect().find(text: String(localized: "no_cats_found")))
    }

    
    func test_errorScenario_viewModel_CatHomeView() throws {
        //Arrange
        fakeCatService.scenario = .failure
        
        let view = CatHomeView(catHomeViewModel: self.catHomeViewModel).environmentObject(Router<CataasNavigation>())
        let expectation = expectation(description: "Request state is error")
        catHomeViewModel.$requestState.sink { state in
            if state == RequestState.error() {
                expectation.fulfill()
            }
        }
        .store(in: &cancellables)
        
        //Act
        ViewHosting.host(view: view)
        
        //Assert
        wait(for: [expectation], timeout: 3)
        let cards = try view.inspect().findAll(CatCardView.self)
        XCTAssertEqual(cards.count, 0)
        _ = try XCTUnwrap(try? view.inspect().find(SadCatErrorView.self))
                     
    }

}
