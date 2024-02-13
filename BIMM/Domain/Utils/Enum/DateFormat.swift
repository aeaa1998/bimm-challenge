//
//  DateFormat.swift
//  BIMM
//
//  Created by Augusto Alonso on 8/02/24.
//

import Foundation

enum DateFormat {
    case iso8601, custom(String)
    
    var value: String {
        switch self {
        case .iso8601:
            return "yyyy-MM-dd"
        case .custom(let format):
            return format
        }
    }
}
