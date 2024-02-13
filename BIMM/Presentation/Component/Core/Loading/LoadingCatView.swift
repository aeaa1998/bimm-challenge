//
//  LoadingCatView.swift
//  BIMM
//
//  Created by Augusto Alonso on 12/02/24.
//

import SwiftUI

struct LoadingCatView: View {
    @Environment(\.theme) var theme
    
    let text: LocalizedStringKey
    
    private let size: CGFloat = 200
    
    init(_ text: LocalizedStringKey = "detault_loading_message") {
        self.text = text
    }
    
    var body: some View {
        VStack(spacing: 8) {
            Image("loading-cat")
                .resizable()
                .frame(width: size, height: size)
                .clipShape(Circle())
            
            
            Text(text)
                .multilineTextAlignment(.center)
                .padding()
                .background(.thinMaterial)
                .clipShape(theme.shapes.small)
            
            ProgressView()
                .controlSize(.regular)
        }
        .padding()
    }
}

#Preview {
    LoadingCatView()
}
