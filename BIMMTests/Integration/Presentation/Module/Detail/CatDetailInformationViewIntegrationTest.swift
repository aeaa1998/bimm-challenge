//
//  CatDetailInformationViewIntegrationTest.swift
//  BIMMTests
//
//  Created by Augusto Alonso on 9/02/24.
//

import XCTest
import ViewInspector
import SwiftUI
@testable import BIMM

final class CatDetailInformationViewIntegrationTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_owner_CatDetailInformationView() throws {
        //Arrange
        let cat: CatDetail = .init(id: "id", tags: [], owner: "testowner", mimetype: "mime", createdAt: Date(), updatedAt: Date())
        let view = CatDetailInformationView(cat: cat)
        
        //Assert
        _ = try XCTUnwrap(try? view.inspect().find(text: cat.owner!))
    }
    
    func test_ownerNil_CatDetailInformationView() throws {
        //Arrange
        let cat: CatDetail = .init(id: "id", tags: [], owner: nil, mimetype: "mime", createdAt: Date(), updatedAt: Date())
        let view = CatDetailInformationView(cat: cat)
        
        //Assert
        _ = try XCTUnwrap(try? view.inspect().find(text: String(localized: "cat_has_no_owner")))
    }
    
    func test_tags_CatDetailInformationView() throws {
        //Arrange
        let cat: CatDetail = .init(id: "id", tags: ["test", "tag1", "tag3"], owner: nil, mimetype: "mime", createdAt: Date(), updatedAt: Date())
        let view = CatDetailInformationView(cat: cat)
        
        //Assert
        let tagViews = try view.inspect().findAll(ChipView<Text>.self)
        XCTAssertEqual(tagViews.count, cat.tags.count)
    }
    
    func test_tagsEmpty_CatDetailInformationView() throws {
        //Arrange
        let cat: CatDetail = .init(id: "id", tags: [], owner: nil, mimetype: "mime", createdAt: Date(), updatedAt: Date())
        let view = CatDetailInformationView(cat: cat)
        
        //Assert
        _ = try XCTUnwrap(try? view.inspect().find(text: String(localized: "cat_no_tags")))
    }
    
    func test_metadata_CatDetailInformationView() throws {
        //Arrange
        let cat: CatDetail = .init(id: "id", tags: [], owner: nil, mimetype: "mime", createdAt: Date(), updatedAt: Date().addingTimeInterval(1000))
        let view = CatDetailInformationView(cat: cat)
        
        //Assert
        //Mime visible
        _ = try XCTUnwrap(try? view.inspect().find(text: "mime"))
        //Created at visible
        _ = try XCTUnwrap(try? view.inspect().find(text: cat.createdAt.formatted(dateStyle: .long, timeStyle: .none)))
        //Updated at visible
        _ = try XCTUnwrap(try? view.inspect().find(text: cat.updatedAt.formatted(dateStyle: .long, timeStyle: .none)))
    }
}
