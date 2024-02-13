//
//  Cat.swift
//  BIMM
//
//  Created by Augusto Alonso on 6/02/24.
//

import Foundation

struct Cat : Identifiable {
    let id: String
    let tags: [String]
    let owner: String?
    let createdAt: Date
    let updatedAt: Date
}
