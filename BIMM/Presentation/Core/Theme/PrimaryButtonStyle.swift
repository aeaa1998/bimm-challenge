//
//  PrimaryButtonStyle.swift
//  BIMM
//
//  Created by Augusto Alonso on 12/02/24.
//

import SwiftUI


struct ThemeButton {
    struct PrimaryStyle : ButtonStyle {
        @Environment(\.theme) var theme
        
        func makeBody(configuration: Configuration) -> some View {
            configuration.label
                .padding()
        }
    }
    
    struct SecondaryStyle : ButtonStyle {
        @Environment(\.theme) var theme
        
        func makeBody(configuration: Configuration) -> some View {
            configuration.label
                .padding()
        }
    }
    
    struct IconStyle : ButtonStyle {
        @Environment(\.isEnabled) private var isEnabled: Bool
        @Environment(\.theme) private var theme

        let tint: Color
        func makeBody(configuration: Configuration) -> some View {
            configuration.label
                .padding(8)
                .background(!isEnabled ? Color.clear : tint.opacity(0.25))
                .background(.regularMaterial)
                .foregroundStyle(!isEnabled ? Color.gray : tint)
                .clipShape(theme.shapes.small)
        }
    }
}




extension View {
    func iconButtonStyle(with tint: Color) -> some View {
        self.buttonStyle(ThemeButton.IconStyle(tint: tint))
    }
    
    func primaryButtonStyle() -> some View {
        self.buttonStyle(ThemeButton.PrimaryStyle())
    }
    
    func secondaryButtonStyle() -> some View {
        self.buttonStyle(ThemeButton.SecondaryStyle())
    }
}
