//
//  CatProtocol.swift
//  BIMM
//
//  Created by Augusto Alonso on 9/02/24.
//

import Foundation

protocol CatProtocol {
    var id: String { get }
    var tags: [String] { get }
    var owner: String? { get }
}
