//
//  CatCardViewTest.swift
//  BIMMTests
//
//  Created by Augusto Alonso on 9/02/24.
//

import XCTest
import ViewInspector
import SwiftUI
@testable import BIMM

final class CatCardViewIntegrationTest: XCTestCase {

    func test_id_CatCardView() throws {
        //Arrange
        let cat = Cat(id: "test", tags: [], owner: "owner")
        let view = CatCardView(cat: cat)
        
        //Assert
        _ = try XCTUnwrap(try? view.inspect().find(text: cat.id))
    }


    func test_owner_CatCardView() throws {
        //Arrange
        let cat = Cat(id: "test", tags: [], owner: "owner")
        let view = CatCardView(cat: cat)
        
        //Assert
        _ = try XCTUnwrap(try? view.inspect().find(text: cat.owner!))
    }
    
    func test_ownerNil_CatCardView() throws {
        //Arrange
        let cat = Cat(id: "test", tags: [], owner: nil)
        let view = CatCardView(cat: cat)
        
        //Assert
        _ = try XCTUnwrap(try? view.inspect().find(text: String(localized: "cat_has_no_owner")))
    }
    
    func test_tags_CatCardView() throws {
        //Arrange
        let cat = Cat(id: "test", tags: ["tag1", "tag2"], owner: "owner")
        let view = CatCardView(cat: cat)
        
        //Assert
        let tagViews = try view.inspect().findAll(ChipView<Text>.self)
        XCTAssertEqual(cat.tags.count, tagViews.count)
    }
    
    func test_tagsEmpty_CatCardView() throws {
        //Arrange
        let cat = Cat(id: "test", tags: [], owner: "owner")
        let view = CatCardView(cat: cat)
        
        //Assert
        let tagViews = try view.inspect().findAll(ChipView<Text>.self)
        XCTAssertTrue(tagViews.isEmpty)
    }
    
    func test_tagLimit_CatCardView() throws {
        //Arrange
        var tags = [String]()
        for i in (1...100) {
            tags.append("tag \(i)")
        }
        let cat = Cat(id: "test", tags: tags, owner: "owner")
        let view = CatCardView(cat: cat)
        
        //Assert
        let tagViews = try view.inspect().findAll(ChipView<Text>.self)
        XCTAssertEqual(10, tagViews.count)
    }


    func test_tagSelectedFilter_CatCardView() throws {
        //Arrange
        var tags = [String]()
        for i in (1...100) {
            tags.append("tag \(i)")
        }
        
        let cat = Cat(id: "test", tags: tags, owner: "owner")
        let view = CatCardView(cat: cat, filterTags: [cat.tags.last!])
        
        //Assert
        let tagViews = try view.inspect().findAll(ChipView<Text>.self)
        XCTAssertEqual(try tagViews.first!.text().string(), cat.tags.last!)
    }

}
