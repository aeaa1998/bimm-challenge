//
//  UnderlineTextFieldView.swift
//  BIMM
//
//  Created by Augusto Alonso on 12/02/24.
//

import SwiftUI

struct UnderlineTextFieldView: View {
    @Environment(\.theme) var theme
    let placeholder: LocalizedStringKey
    @Binding var text: String
    
    init(_ placeholder: LocalizedStringKey, text: Binding<String>) {
        self.placeholder = placeholder
        self._text = text
    }
    
    var body: some View {
        VStack(spacing: 6) {
            TextField("cat_talk_placeholder", text: $text)
                .foregroundStyle(.primary)
            
            Spacer()
                .frame(height: 3)
                .frame(maxWidth: .infinity)
                .background(theme.palette.primary)
        }
    }
}

#Preview {
    UnderlineTextFieldView("cat_talk_placeholder", text: .constant(""))
}
