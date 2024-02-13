//
//  DetailTab.swift
//  BIMM
//
//  Created by Augusto Alonso on 9/02/24.
//

import Foundation

enum DetailTab : String, CaseIterable, Identifiable {
    case information, talk
    
    var id: String {
        self.rawValue
    }
}
