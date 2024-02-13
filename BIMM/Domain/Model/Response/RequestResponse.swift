//
//  RequestResponse.swift
//  BIMM
//
//  Created by Augusto Alonso on 6/02/24.
//

import Foundation
import SwiftyJSON
import Alamofire

struct RequestResponse<Data> {
    var data: Data?
    var error: Error?
    
    var afError: AFError? {
        error?.asAFError
    }
    
    var errorJson : JSON? {
        let errorJson = afError?.errorJson
        if errorJson != nil {
            return errorJson
        }
        switch error as? HttpError {
        case .error(_, let json):
            return json
        case .serverError(let json):
            return json
        case .unauthorized(let json):
            return json
        default:
            return nil
            
        }
    }
}
