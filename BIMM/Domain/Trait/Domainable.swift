//
//  Domainable.swift
//  BIMM
//
//  Created by Augusto Alonso on 8/02/24.
//

import Foundation

//Protocol describing the capability to transform one object into a domain
protocol Domainable {
    associatedtype Domain
    func toDomain() -> Domain
}
