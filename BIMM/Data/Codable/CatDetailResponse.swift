//
//  CatDetailResponse.swift
//  BIMM
//
//  Created by Augusto Alonso on 9/02/24.
//

import Foundation

struct CatDetailResponse : Codable {
    let id: String
    let tags: [String]
    let mimetype: String
    let createdAt: String
    let updatedAt: String
    
    private enum CodingKeys : String, CodingKey {
        case id = "_id", tags, mimetype, createdAt, updatedAt = "editedAt"
    }
}
