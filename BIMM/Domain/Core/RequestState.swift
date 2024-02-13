//
//  RequestState.swift
//  BIMM
//
//  Created by Augusto Alonso on 8/02/24.
//

import Foundation

enum RequestState : Equatable {
    case loading, success, error(_ error: Error? = nil), none
    
    static func == (lhs: RequestState, rhs: RequestState) -> Bool {
        lhs.code == rhs.code
    }
    
    private var code: Int? {
        switch self {
        case .success:
            return 1
        case .loading:
            return 0
        case .error(_):
            return -1
        case .none:
            return nil
        }
    }
}
