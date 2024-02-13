//
//  Theme.swift
//  BIMM
//
//  Created by Augusto Alonso on 12/02/24.
//

import SwiftUI

protocol Theme {
    let palette: ColorPalette
    
    struct ColorPalette {
        let primary: Color
        let secondary: Color
    }
    
}
