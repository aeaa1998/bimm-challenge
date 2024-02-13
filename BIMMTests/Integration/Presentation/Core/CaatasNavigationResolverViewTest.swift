//
//  RouterDestinationResolverViewIntegrationTest.swift
//  BIMMTests
//
//  Created by Augusto Alonso on 12/02/24.
//

import XCTest
import ViewInspector
import SwiftUI
@testable import BIMM

final class CaatasNavigationResolverView : XCTestCase {
    func test_homeViewPath() throws {
        //Arrange
        let view = CaatasNavigationResolverView(destination: .home)
        
        //Assert
        _ = try XCTUnwrap(try? view.inspect().find(CatHomeView.self) )
    }
    
    func test_detailViewPath() throws {
        //Arrange
        let view = CaatasNavigationResolverView(destination: .detail(cat: .init(id: "", tags: [], owner: nil)))
        
        //Assert
        _ = try XCTUnwrap(try? view.inspect().find(CatDetailView.self) )
    }
}
