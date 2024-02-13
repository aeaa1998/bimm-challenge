//
//  File.swift
//  BIMM
//
//  Created by Augusto Alonso on 9/02/24.
//

import Foundation

class FakeCatService : CatServiceProtocol {
    var scenario = Scenario.success
    func getCats() async -> RequestResponse<[Cat]> {
        switch scenario {
        case .success:
            return .init(data: FakeCatService.catsList)
        case .failure:
            return .init(data: nil, error: "failed")
        case .empty:
            return .init(data: [])
        }
    }
    
    func getTags() async -> RequestResponse<[String]> {
        switch scenario {
        case .success:
            return .init(data: ["tag1", "tag2"])
        case .failure:
            return .init(data: nil, error: "failed")
        case .empty:
            return .init(data: [])
        }
    }
    
    func getCat(for cat: Cat) async -> RequestResponse<CatDetail> {
        switch scenario {
        case .success, .empty:
            return .init(data: FakeCatService.catDetail)
        default:
            return .init(data: nil, error: "failed")
        }
    }
    
    enum Scenario {
        case success, failure, empty
    }
    
    static let catDetail: CatDetail = .init(id: "JYpbBMDo6Hexm6OB", tags: ["tags1"], owner: "owner", mimetype: "png", createdAt: Date(), updatedAt: Date())
    static let catsList: [Cat] = [.init(id: "cat1", tags: ["tag1", "tag2"], owner: "owner"), .init(id: "cat2", tags: ["tag4", "tag1"], owner: "owner")]
}
