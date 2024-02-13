//
//  CatDetail.swift
//  BIMM
//
//  Created by Augusto Alonso on 9/02/24.
//

import Foundation

struct CatDetail : Identifiable, Codable, Equatable, Hashable, CatProtocol {
    let id: String
    let tags: [String]
    let owner: String?
    let mimetype: String
    let createdAt: Date
    let updatedAt: Date
}
