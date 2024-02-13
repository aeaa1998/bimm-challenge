//
//  BIMMUITests.swift
//  BIMMUITests
//
//  Created by Augusto Alonso on 8/02/24.
//

import XCTest

final class BIMMUITestNavigation: XCTestCase {
    var bundle: Bundle?
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        bundle = Bundle(for: BIMMUITestNavigation.self)

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_navigationToDetail() throws {
        // Arrange
        let app = XCUIApplication()
        app.launch()
        //In this scenario we can use the id because the data comes from the json file
        let catIdLabel = app.staticTexts["xkO0UNOv5HgUjmdm"]
        XCTAssert(catIdLabel.waitForExistence(timeout: 8))
        
        
        //Act
        catIdLabel.tap()
        
        //Assert
        let homeViewTitleNavigation = app.navigationBars[String(localized: "cat_home_title")]
        XCTAssertFalse(homeViewTitleNavigation.exists)
        
        let predicate = NSPredicate(format: "label CONTAINS[c] %@", String(localized: "detail_for", bundle: bundle))
        let detailTitle = app.staticTexts.containing(predicate)
        //Asert we are in the detail view
        XCTAssert(detailTitle.element.waitForExistence(timeout: 8))
    }


}
