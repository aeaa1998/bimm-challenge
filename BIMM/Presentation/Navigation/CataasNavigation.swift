//
//  CataasNavigation.swift
//  BIMM
//
//  Created by Augusto Alonso on 10/02/24.
//

import Foundation

enum CataasNavigation: Codable, Hashable {
    case home
    case detail(cat: Cat)
}
