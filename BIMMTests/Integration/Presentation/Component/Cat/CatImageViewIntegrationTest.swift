//
//  CatImageViewIntegrationTest.swift
//  BIMMTests
//
//  Created by Augusto Alonso on 9/02/24.
//

import XCTest
import ViewInspector
import CachedAsyncImage
import SwiftUI

@testable import BIMM

final class CatImageViewIntegrationTest: XCTestCase {

    func test_urlCached_CatImageView() throws {
        //Arrange
        let id = "test"
        let view = CatImageView(id: id, cached: true)
        
        //Assert
        _ = try XCTUnwrap(try? view.inspect().find(viewWithTag: "cat_image_cached_\(id)"))
    }
    
    func test_urlNotCached_CatImageView() throws {
            let id = "test"
        //Arrange
        let view = CatImageView.init(id: "test", cached: false)
        
        //Assert
            _ = try XCTUnwrap(try? view.inspect().find(viewWithTag: "cat_image_\(id)"))
    }

}
