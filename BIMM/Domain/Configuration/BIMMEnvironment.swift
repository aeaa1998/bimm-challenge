//
//  BIMMEnvironment.swift
//  BIMM
//
//  Created by Augusto Alonso on 8/02/24.
//

import Foundation

//This structs represent the environment options in the config file
enum BIMMEnvironment {
    case baseURL
    
    private var key: String {
        switch self {
        case .baseURL:
            return "CATAAS_BASE_URL"
        }
    }
    var value: String {
        
        guard let value  = Bundle.main.object(forInfoDictionaryKey: key) as? String else {
            fatalError("Required environment value is not properly configured")
        }
        return value
    }
}
