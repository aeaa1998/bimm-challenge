//
//  TabRow.swift
//  BIMM
//
//  Created by Augusto Alonso on 9/02/24.
//

import SwiftUI

struct TabRow: View {
    let text: String
    let selected: Bool
    
    init(_ text: String, selected: Bool) {
        self.text = text
        self.selected = selected
    }
    
    var body: some View {
        VStack {
            Text(text)
                .padding(.horizontal)
            
            GeometryReader { proxy in
                let localFrame = proxy.frame(in: .local)
                Spacer()
                    .frame(width: localFrame.width, height: 4)
                    .animation(.easeIn, value: selected)
                    .background(!selected ? Color.clear : Color.appPrimary)
            }
        }
        .padding(.vertical)
    }
}

#Preview {
    TabRow("TZ", selected: true)
}
