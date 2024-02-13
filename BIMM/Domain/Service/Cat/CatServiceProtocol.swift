//
//  CatServiceProtocol.swift
//  BIMM
//
//  Created by Augusto Alonso on 8/02/24.
//

import Foundation


protocol CatServiceProtocol {
    func getCats() async -> RequestResponse<[Cat]>
    func getTags() async -> RequestResponse<[String]>
    func getCat(for cat: Cat) async -> RequestResponse<CatDetail>
}
