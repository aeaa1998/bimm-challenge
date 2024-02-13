//
//  BIMMBundles.swift
//  BIMM
//
//  Created by Augusto Alonso on 8/02/24.
//

import Foundation


enum BIMMBundles {
    case support
    var path : String {
        switch self {
        case .support:
            return (Bundle.main.resourcePath ?? "") + "/Support.bundle"
        }
    }
    
    
    var bundle: Bundle? {
        return Bundle(path: self.path)
    }
    
}
