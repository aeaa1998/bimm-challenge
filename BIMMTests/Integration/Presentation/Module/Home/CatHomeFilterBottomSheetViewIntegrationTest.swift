//
//  CatHomeFilterBottomSheetViewIntegrationTest.swift
//  BIMMTests
//
//  Created by Augusto Alonso on 11/02/24.
//

import XCTest
import SwiftUI
import ViewInspector
import Combine
@testable import BIMM

final class CatHomeFilterBottomSheetViewIntegrationTest: XCTestCase {
    private var state : CatHomeFilterState!
    private let options = ["tag1", "tag2", "tag3", "tag4"]
    override func setUpWithError() throws {
        state = .init()
    }

    

    func test_emptyState_CatHomeFilterBottomSheetView() throws {
        //Arrange
        let view = CatHomeFilterBottomSheetView(state: state)
        
        //Assert
        _ = try XCTUnwrap(try? view.inspect().find(text: String(localized: "no_results")))
    }

    func test_tagsVisible_CatHomeFilterBottomSheetView() throws {
        //Arrange
        state.options = Set(options)
        let view = CatHomeFilterBottomSheetView(state: state)
        
        //Assert
        let tagViews = try view.inspect().findAll(CatHomeFilterChipView.self)
        
        XCTAssertEqual(tagViews.count, tagViews.count)
    }
    
    func test_tagsLimit_CatHomeFilterBottomSheetView() throws {
        //Arrange
        var tags = [String]()
        for i in (1...100) {
            tags.append("tag \(i)")
        }
        state.options = Set(tags)
        let view = CatHomeFilterBottomSheetView(state: state)
        
        //Assert
        let tagViews = try view.inspect().findAll(CatHomeFilterChipView.self)
        
        XCTAssertEqual(tagViews.count, 14)
    }
    
    
    
    func test_tagsFiltered_CatHomeFilterBottomSheetView() throws {
        //Arrange
        state.options = Set(options)
        state.search = "1"
        state.showAllOptions = true
        let view = CatHomeFilterBottomSheetView(state: state)
        
        //Assert
        let tagViews = try view.inspect().findAll(CatHomeFilterRowView.self)
        
        XCTAssertEqual(tagViews.count, 1)
    }
    
    
    func test_tagsSelect_CatHomeFilterBottomSheetView() throws {
        //Arrange
        state.options = Set(options)
        let view = CatHomeFilterBottomSheetView(state: state)
        
        //Act
        let tagToSelect = try view.inspect().find(CatHomeFilterChipView.self) { chipview in
            (try? chipview.find(text: "tag3")) != nil
        }
        try tagToSelect.callOnTapGesture()
        
        //Assert
        XCTAssertEqual(state.holder, ["tag3"])
    }
    
    
    func test_tagsApply_CatHomeFilterBottomSheetView() throws {
        //Arrange
        let expect = ["tag3", "tag4"]
        state.options = Set(options)
        state.holder = expect
        let view = CatHomeFilterBottomSheetView(state: state)

        //Act
        let button = try view.inspect().find(button: String(localized: "done"))
        
        try button.tap()
        
        //Assert
        XCTAssertEqual(state.selected, expect)
    }
    
    func test_tagsreset_CatHomeFilterBottomSheetView() throws {
        //Arrange
        let expect = ["tag3", "tag4"]
        state.options = Set(options)
        state.selected = expect
        state.holder = options
        
        let view = CatHomeFilterBottomSheetView(state: state)

        //Act
        let button = try view.inspect().find(button: String(localized: "reset"))
        
        try button.tap()
        
        //Assert
        XCTAssertEqual(state.holder, expect)
    }

}
