//
//  CatDetailViewTest.swift
//  BIMMUITests
//
//  Created by Augusto Alonso on 9/02/24.
//

import XCTest
import SwiftUI
import ViewInspector
import Combine
@testable import BIMM


final class CatDetailViewIntegrationTest: XCTestCase {

    private var catDetailViewModel : CatDetailViewModel!
    private var fakeCatService : FakeCatService!
    private var cancellables: [AnyCancellable] = []
    
    override func setUpWithError() throws {
        //Setup for each test an isolated instance
        fakeCatService = .init()
        catDetailViewModel = .init(catService: fakeCatService)
    }

    func test_sucessState_forCatDetailView_Content() throws {
        //Arrange
        let cat = FakeCatService.catDetail
        let view = CatDetailView.Content(id: cat.id, cat: cat, requestState: .success, selected: .init(get: { DetailTab.information }, set: { _ in }))
        
        //Assert
        _ = try XCTUnwrap(view.inspect().find(text: getTextId(cat.id)))
        _ = try XCTUnwrap(view.inspect().find(text: cat.owner!))
        
        //Information View is shown
        _ = try XCTUnwrap(view.inspect().find(CatDetailInformationView.self))
        
        //Get the tags
        let tagViews = try view.inspect().findAll(ViewType.Text.self, where: { text in
            guard let text = try? text.string() else { return false }
            return cat.tags.contains(text)
        })
        
        XCTAssertTrue(tagViews.count == cat.tags.count)
    }
    
    
    func test_failureState_forCatDetailView_Content() throws {
        //Arrange
        
        let view = CatDetailView.Content(id: "test", cat: nil, requestState: .error("failed"), selected: .init(get: { DetailTab.information }, set: { _ in }))
        
        //Assert
        _ = try XCTUnwrap(view.inspect().find(text: getTextId("test")))

        //Error view is shown
        _ = try XCTUnwrap(view.inspect().find(SadCatErrorView.self))
        
        //The other view are not shown
        XCTAssertNil(try? view.inspect().find(CatDetailInformationView.self))
        XCTAssertNil(try? view.inspect().find(CatDetailTalkView.self))

    }
    
    func test_loadingState_forCatDetailView_Content() throws {
        //Arrange
        
        let view = CatDetailView.Content(id: "test", cat: nil, requestState: .loading, selected: .init(get: { DetailTab.information }, set: { _ in }))
        
        //Assert
        _ = try XCTUnwrap(view.inspect().find(text: getTextId("test")))

        //Loading view is shown
        _ = try XCTUnwrap(view.inspect().find(ViewType.ProgressView.self))
        
        //The other view are not shown
        XCTAssertNil(try? view.inspect().find(CatDetailInformationView.self))
        XCTAssertNil(try? view.inspect().find(CatDetailTalkView.self))
        XCTAssertNil(try? view.inspect().find(SadCatErrorView.self))

    }
    
    func test_viewModelSucess_forCatDetailView() throws {
        //Arrange
        fakeCatService.scenario = .success
        let cat = FakeCatService.catDetail
        let view = CatDetailView.init(cat: .init(id: cat.id, tags: [], owner: cat.owner), catDetailViewModel: self.catDetailViewModel)
        let expectation = expectation(description: "Request state is successfull")
        self.catDetailViewModel.$requestState.sink { state in
            if state == RequestState.success {
                expectation.fulfill()
            }
        }
        .store(in: &cancellables)
        
        
        
        //Act
        ViewHosting.host(view: view)
        
        //Assert
        wait(for: [expectation], timeout: 3)
        _ = try XCTUnwrap(try view.inspect().find(CatDetailInformationView.self))
    }
    
    func test_viewModelFail_forCatDetailView() throws {
        //Arrange
        fakeCatService.scenario = .failure
        let cat = FakeCatService.catDetail
        let view = CatDetailView(cat: .init(id: cat.id, tags: [], owner: cat.owner), catDetailViewModel: self.catDetailViewModel)
        let expectation = expectation(description: "Request state is failure")
        self.catDetailViewModel.$requestState.sink { state in
            if state == RequestState.error() {
                expectation.fulfill()
            }
        }
        .store(in: &cancellables)
        
        
        
        //Act
        ViewHosting.host(view: view)
        
        //Assert
        wait(for: [expectation], timeout: 3)
        _ = try XCTUnwrap(try view.inspect().find(SadCatErrorView.self))
    }
    
    func test_tabChange_forCatDetailView_Content() throws {
        //Arrange
        let selected = Binding<DetailTab>(wrappedValue: .information)
        let cat = FakeCatService.catDetail
        let view = CatDetailView.Content(id: cat.id, cat: cat, requestState: .success, selected: selected)
        
        //Act
        let text = try XCTUnwrap(try view.inspect().find(ViewType.Button.self) { tabRow in
            (try? tabRow.find(text: String(localized: "talk"))) != nil
        })
        
        try text.tap()
        
        //Assert
        XCTAssertNil(try? view.inspect().find(CatDetailInformationView.self))
        _ = try XCTUnwrap(try view.inspect().find(CatDetailTalkView.self))
    }
    
    
    private func getTextId(_ id: String) -> String{
        return String(localized: "detail_for") + " \(id)"
    }
}
