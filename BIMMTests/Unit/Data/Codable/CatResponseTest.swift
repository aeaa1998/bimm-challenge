//
//  CatResponseTest.swift
//  BIMMTests
//
//  Created by Augusto Alonso on 9/02/24.
//

import XCTest
@testable import BIMM

class CatResponseTest : XCTestCase {

    func test_catResponseToDomain_sucess(){
        let catResponse = CatResponse(id: "id", tags: ["i feel"], owner: "real")
        let expected = Cat(id: "id", tags: ["i feel"], owner: "real")
        
        XCTAssertEqual(catResponse.toDomain(), expected)
    }
}
