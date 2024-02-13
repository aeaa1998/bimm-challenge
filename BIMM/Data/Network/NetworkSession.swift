//
//  NetworkingSession.swift
//  BIMM
//
//  Created by Augusto Alonso on 6/02/24.
//

import Foundation
import Alamofire

struct NetworkingSession {
    //The default implementation of a session
    static let `default`: Session = {
        let timeout: TimeInterval = 100
        let configuration = URLSessionConfiguration.af.default
        configuration.timeoutIntervalForRequest = timeout
        
        return Session(configuration: configuration)
    }()
}
