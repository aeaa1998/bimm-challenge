//
//  CatHomeFilterStateTest.swift
//  BIMMTests
//
//  Created by Augusto Alonso on 11/02/24.
//

import XCTest
import Combine
@testable import BIMM

final class CatHomeFilterStateTest : XCTestCase {
    private var catHomeFilterState : CatHomeFilterState!
    private var cancellables: [AnyCancellable] = []
    
    override func setUpWithError() throws {
        //Setup for each test an isolated instance
        catHomeFilterState = .init()
    }
    
    
    func test_toggleSelectAdds_CatHomeFilterStateTest() async {
        //Arrange
        catHomeFilterState.options = .init(["test1", "test2", "test3"])
        
        //Act
        catHomeFilterState.toggleSelecteTag(for: "test1")
        
        //Asssert
        XCTAssertEqual(catHomeFilterState.holder, ["test1"])
        XCTAssertEqual(catHomeFilterState.selected, [])
    }
    
    
    func test_toggleSelectRemoves_CatHomeFilterStateTest() async {
        //Arrange
        catHomeFilterState.options = .init(["test1", "test2", "test3"])
        
        //Act
        catHomeFilterState.toggleSelecteTag(for: "test1")
        catHomeFilterState.toggleSelecteTag(for: "test1")
        
        //Asssert
        XCTAssertEqual(catHomeFilterState.holder, [])
        XCTAssertEqual(catHomeFilterState.selected, [])
    }
    
    func test_resetSelected_CatHomeFilterStateTest() async {
        //Arrange
        catHomeFilterState.options = .init(["test1", "test2", "test3"])
        catHomeFilterState.selected = ["test1"]
        
        //Act
        catHomeFilterState.toggleSelecteTag(for: "test2")
        catHomeFilterState.toggleSelecteTag(for: "test1")
        catHomeFilterState.reset()
        
        //Asssert
        XCTAssertEqual(catHomeFilterState.holder, ["test1"])
    }

    func test_applySelected_CatHomeFilterStateTest() async {
        //Arrange
        catHomeFilterState.options = .init(["test1", "test2", "test3"])
        
        //Act
        catHomeFilterState.toggleSelecteTag(for: "test2")
        catHomeFilterState.toggleSelecteTag(for: "test1")
        catHomeFilterState.apply()
        
        //Asssert
        XCTAssertEqual(catHomeFilterState.selected, ["test2", "test1"])
    }
}
