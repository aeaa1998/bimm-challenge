//
//  CatHomeFilterChipView.swift
//  BIMM
//
//  Created by Augusto Alonso on 11/02/24.
//

import Foundation
import SwiftUI

struct CatHomeFilterChipView : View {
    @Environment(\.theme) var theme
    @Environment(\.colorScheme) var colorScheme
    let tag: String
    let selected: Bool
    
    private var chipColor: Color {
        colorScheme == .dark ? theme.palette.secondary : theme.palette.primary
    }
    
    private var shape: RoundedRectangle {
        theme.shapes.large
    }
    
    var body: some View {
        ChipView(tag, size: .custom(x: 16, y: 6))
            .font(.body.weight(.light))
            .background(selected ? chipColor : .clear)
            .foregroundStyle(selected ? .white : .primary)
            .clipShape(shape)
            .overlay {
                shape.strokeBorder(chipColor)
            }
            .animation(.linear, value: selected)
            .accessibilityAddTraits([.isButton])
    }
}


#Preview("Unselected") {
    CatHomeFilterChipView(tag: "test", selected: false)
}

#Preview("Selected") {
    CatHomeFilterChipView(tag: "test", selected: true)
        .colorScheme(.dark)
}
