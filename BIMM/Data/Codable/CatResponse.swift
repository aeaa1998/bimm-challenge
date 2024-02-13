//
//  CatResponse.swift
//  BIMM
//
//  Created by Augusto Alonso on 8/02/24.
//

import Foundation


struct CatResponse : Codable {
    let id: String
    let tags: [String]
    let owner: String?
    
    private enum CodingKeys : String, CodingKey {
        case id = "_id", tags, owner
    }
}


extension CatResponse : Domainable {
    func toDomain() -> Cat {
        return Cat(id: id, tags: tags, owner: owner)
    }
}
