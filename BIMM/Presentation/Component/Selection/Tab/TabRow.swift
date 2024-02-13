//
//  TabRow.swift
//  BIMM
//
//  Created by Augusto Alonso on 9/02/24.
//

import SwiftUI

struct TabRow: View {
    @Environment(\.theme) var theme
    @Environment(\.tabColor) var tabColor: Color?

    let selected: Bool
    private let text: Text
    private let duration: Double = 0.3
    
    private var color: Color {
        tabColor ?? theme.palette.primary
    }
    
    init(_ text: String, selected: Bool) {
        self.text = Text(text)
        self.selected = selected
    }
    
    init(_ text: LocalizedStringKey, selected: Bool) {
        self.text = Text(text)
        self.selected = selected
    }
    
    
    var body: some View {
        VStack(spacing: 5) {
            text
                .padding(.horizontal)
                .animation(.easeOut(duration: duration), value: selected)
                .foregroundStyle(selected ? color : .primary)
                .bold(selected)
                
            
            GeometryReader { proxy in
                let localFrame = proxy.frame(in: .local)
                Spacer()
                    .frame(width: localFrame.width, height: 4)
                    .background(!selected ? Color.gray : tabColor)
                    .animation(.easeOut(duration: duration), value: selected)
                    
            }
            .frame(maxHeight: 4)
        }
        .padding(.vertical)
    }
}

#Preview {
    TabRow("TZ", selected: false)
        .background(BIMMTheme.default.palette.secondary)
}
