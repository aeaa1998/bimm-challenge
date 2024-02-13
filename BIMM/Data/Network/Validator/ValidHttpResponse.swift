//
//  ValidHttpResponse.swift
//  BIMM
//
//  Created by Augusto Alonso on 8/02/24.
//

import Foundation
import Alamofire
import SwiftyJSON

fileprivate var acceptableStatusCodes: Range<Int> { 200..<300 }

/// This class creates an instance of a Http Response validator we use this to get beeter results with the error handling
/// tahnks to this class we can eget the error JSON associated with the response if there is one
class ValidHttpResponse {
    
    var validate: DataRequest.Validation = { request, response, data in
        //Is an acceptable status code
        if acceptableStatusCodes.contains(response.statusCode) {
            return .success(Void())
        } else {
            let json: JSON?
            //Get the json if there is one with the data
            if let data = data {
                json = try? JSON(data: data)
            }else{
                json = nil
            }
            switch response.statusCode {
            //Timeout
            case 504:
                return .failure(HttpError.timeOut)
            //Unauthorized
            case 401:
                return .failure(HttpError.unauthorized(json))
            //Server error
            case 500:
                return .failure(HttpError.serverError(json))
            default:
                return .failure(HttpError.error(response.statusCode, json))
            }
        }
        
    }
}
