//
//  Theme.swift
//  BIMM
//
//  Created by Augusto Alonso on 12/02/24.
//

import SwiftUI

protocol Theme {
    var palette: ColorPalette { get }
    var shapes: ShapeCatalog { get }
    var backgrounds: BackgoundCatalog { get }
}

struct ColorPalette {
    let primary: Color
    let secondary: Color
}

struct ShapeCatalog {
    let small: RoundedRectangle
    let regular: RoundedRectangle
    let large: RoundedRectangle
}

struct BackgoundCatalog {
    //The main background used for normal screens like home
    let background: Color
    // Backgrounds used in sheet content
    let sheet: Color
}

