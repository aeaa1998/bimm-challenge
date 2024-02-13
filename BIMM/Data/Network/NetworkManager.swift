//
//  NetworkManager.swift
//  BIMM
//
//  Created by Augusto Alonso on 8/02/24.
//


import Foundation
import Alamofire
import SwiftyJSON


/// Class NetworkManager which helps in making network calls by using `Session`
/// The class can handle both types of requests, `GET` and `POST`
/// - API: The APi we want to consume later
class NetworkManager<API: Api> {
    let sessionManager: Session
    init(sessionManager: Session = NetworkSession.default){
        self.sessionManager = sessionManager
    }
    
    /// Store all the active cancellables
    var cancellables = [DataRequest]()
     
    /// HTTP Response Validator to validate the response
    let httpValidator: ValidHttpResponse = ValidHttpResponse()
    
  
    
    /// Makes the network call and returns the response in two closure blocks
    /// - Parameters:
    ///   - router: Router, contains the endpoint details and parameters
    ///   - onSuccess: Closure which will be triggered if the network call is successful
    ///   - onError: Closure which will be triggered if the network call fails
    func call<T: Decodable>(
        _ router: API,
        onSuccess: @escaping (T) -> Void,
        onError: @escaping (AFError?) -> Void
    ) {
        let dataRequest = sessionManager.request(router)
        
        let cancellable = dataRequest
            .validate(httpValidator.validate)
            .validate()
            .responseDecodable(of: T.self){ response in
                if let error = response.error {
                    onError(error)
                }else if let value = response.value{
                    onSuccess(value)
                }else{
                    onError(nil)
                }
            }
        
        cancellables.append(cancellable)
    }
    

    
    /// This function is used to make a network call for a given `Router` instance
    /// - Parameters:
    ///   - router: The `Router` instance representing the request to be made
    /// - Returns: A `RequestResponse` instance containing the response data and error
    func call<T: Decodable>(
        _ router: API
    ) async -> DataResponse<T, AFError> {
        // Create a DataRequest instance
        let dataRequest = sessionManager.request(router)
        cancellables.append(dataRequest)
        // Validate the response using the httpValidator and decode it as the provided Decodable type
        let response = dataRequest
            .validate(httpValidator.validate)
            .validate()
            .serializingDecodable(T.self)
        let result = await response.response
        cancellables.removeAll(where: { possible in possible.id == dataRequest.id })
        return result
    }

}

