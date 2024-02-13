//
//  HttpError.swift
//  BIMM
//
//  Created by Augusto Alonso on 8/02/24.
//

import Foundation
import SwiftyJSON
import Alamofire

enum HttpError: Error {
    //For 401 response
    case unauthorized(JSON?)
    
    //For 500 response
    case serverError(JSON?)
    
    //For 404 response
    case notFound
    
    //For 504 response
    case timeOut
    
    //For the rest of error codes
    case error(Int, JSON?)
}

extension AFError {
    var httpError: HttpError? {
        if let httpError = self.underlyingError as? HttpError {
            return httpError
        }
        return nil
    }
    
    var isServerError: Bool {
        if let httpErrorCode = httpStatusCode {
            return httpErrorCode == 500
        }
        return false
    }
    
    var httpStatusCode: Int? {
        if let error = httpError {
            switch error {
            case .unauthorized:
                return 401
            case .serverError( _):
                return 500
            case .notFound:
                return 404
            case .timeOut:
                return 504
            case .error(let int, _):
                return int
            }
        }
        return nil
    }


    var errorJson: JSON? {
        if let error = httpError {
            switch error {
            case .timeOut:
                return nil
            case .unauthorized(let json):
                return json
            case .serverError(let json):
                return json
            case .notFound:
                return nil
            case .error(_, let json):
                return json
            }
        }
        return nil
    }
}

