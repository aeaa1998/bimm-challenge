//
//  CatHomeFilterRowView.swift
//  BIMM
//
//  Created by Augusto Alonso on 12/02/24.
//

import SwiftUI

struct CatHomeFilterRowView: View {
    @Environment(\.theme) var theme
    @Environment(\.colorScheme) var colorScheme
    let tag: String
    let selected: Bool
    
    private var chipColor: Color {
        colorScheme == .dark ? theme.palette.secondary : theme.palette.primary
    }
    
    private var shape: RoundedRectangle {
        theme.shapes.small
    }
    
    
    var body: some View {
        HStack{
            Text(tag)
                
            Spacer()
            
            if selected {
                Image(systemName: "checkmark")
            }
        }
            .padding(.horizontal)
            .padding(.vertical, 8)
            .font(.body.weight( selected ? .bold : .light))
            .background(selected ? chipColor : .clear)
            .foregroundStyle(selected ? .white : .primary)
            .animation(.linear, value: selected)
            .clipShape(shape)
            .contentShape(shape)
    }
}

#Preview("Both options") {
    VStack {
        CatHomeFilterRowView(tag: "Tag", selected: false)
        CatHomeFilterRowView(tag: "Tag", selected: true)
    }
}
