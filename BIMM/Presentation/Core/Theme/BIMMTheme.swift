//
//  BIMMTheme.swift
//  BIMM
//
//  Created by Augusto Alonso on 12/02/24.
//

import SwiftUI

//Contains all of the theme configuration for the application ensuring consistency across the different components
struct BIMMTheme : Theme {
    let palette: ColorPalette
    let shapes: ShapeCatalog
    let backgrounds: BackgoundCatalog
}


//The default implementation

extension BIMMTheme {
    static let `default` = BIMMTheme(
        palette: .init(
            primary: Color(
                light: Color(
                    red: 99/255,
                    green: 141/255,
                    blue: 168/255),
                dark: Color(
                    red: 37/255,
                    green: 113/255,
                    blue: 161/255
                )
            ),
            secondary: Color(
                light: Color(
                    red: 191/255,
                    green: 209/255,
                    blue: 226/255),
                dark: Color(
                    red: 115/255,
                    green: 109/255,
                    blue: 145/255
                )
            )
        ),
        shapes: .init(
            small: RoundedRectangle(cornerRadius: 8),
            regular: RoundedRectangle(cornerRadius: 20),
            large: RoundedRectangle(cornerRadius: 45)
        ),
        backgrounds: .init(
            background: Color.systemBackground,
            sheet: Color.secondarySystemBackground
        )
    )
}
