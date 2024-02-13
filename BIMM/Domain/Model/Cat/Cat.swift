//
//  Cat.swift
//  BIMM
//
//  Created by Augusto Alonso on 8/02/24.
//

import Foundation

struct Cat : Identifiable, Codable, Equatable, Hashable, CatProtocol {
    let id: String
    let tags: [String]
    let owner: String?
}
