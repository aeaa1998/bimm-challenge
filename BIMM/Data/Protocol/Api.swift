//
//  Api.swift
//  BIMM
//
//  Created by Augusto Alonso on 6/02/24.
//

import Foundation
import Alamofire
import SwiftyJSON


/// Protocol for defining an API module with related endpoints
protocol Api : URLRequestConvertible {
    
    /// HTTP method for the API call.
    var method: HTTPMethod { get }
    
    /// JSON parameters for the API call.
    var parameters: JSON? { get }
    
    
    /// Path for the API call.
    var path: String { get }
    
    
    /// Base URL for the API call.
    var baseUrl: String { get }
    
    
    /// Normalizes the URL for the API call.
    ///
    /// - Parameter path: Path for the API call.
    /// - Returns: Normalized URL.
    func normalizeUrl(path: String) -> String
}

//Default implementations for some attributes
extension Api {
    
}

//Default behaviour to create a request from this body
extension Api {
    /// URLRequest convertible method.
    ///
    /// - Returns: URLRequest for API call.
    func asURLRequest() throws -> URLRequest {
        let url = URL(string: baseUrl)!.appendingPathComponent(path)
        var request = URLRequest(url: url)
        
        request.method = method
        
        if let parameters = parameters {
            switch method {
            case .get:
                request = try URLEncodedFormParameterEncoder().encode(parameters, into: request)
            default:
                request = try JSONParameterEncoder().encode(parameters, into: request)
            }
        }
        
        return request
    }
}

