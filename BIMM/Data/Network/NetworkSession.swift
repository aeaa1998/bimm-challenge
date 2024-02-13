//
//  NetworkSession.swift
//  BIMM
//
//  Created by Augusto Alonso on 8/02/24.
//

import Foundation
import Alamofire

struct NetworkSession {
    //The default implementation of a session
    static let `default`: Session = {
        //15 seconds is the timeout for the api call
        let timeout: TimeInterval = 15
        let configuration = URLSessionConfiguration.af.default
        configuration.timeoutIntervalForRequest = timeout
        
        return Session(configuration: configuration)
    }()
}
