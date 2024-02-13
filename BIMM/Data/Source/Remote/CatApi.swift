//
//  CatApi.swift
//  BIMM
//
//  Created by Augusto Alonso on 8/02/24.
//

import Foundation
import Alamofire
import SwiftyJSON

enum CatApi : Api {
    case tags, cat(id: String)
    
    var path: String {
        switch self {
        case .tags:
            return "/api/tags"
        case .cat(id: let id):
            return "/cat/\(id)"
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var parameters: JSON? {
        switch self {
        case .cat(id: _):
            var json = JSON()
            json["json"] = true
            return json
        default:
            return nil
        }
    }
}
