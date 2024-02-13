//
//  SadCatErrorView.swift
//  BIMM
//
//  Created by Augusto Alonso on 9/02/24.
//

import SwiftUI

struct SadCatErrorView: View {
    @Environment(\.theme) var theme
    
    let title: LocalizedStringKey
    let error: Error?
    let onRetry: (() -> Void)?
    
    init(title: LocalizedStringKey, error: Error? = nil, onRetry: (() -> Void)? = nil) {
        self.title = title
        self.error = error
        self.onRetry = onRetry
    }
    
    
    var body: some View {
        VStack(spacing: 8) {

            Image("sad-cat")
                .resizable()
                .frame(width: 150, height: 150)
                .clipShape(Circle())

            VStack {
                Text(title)
                    .multilineTextAlignment(.center)
                
                if let error {
                    Text(error.localizedDescription)
                        .foregroundStyle(.red)
                }
            }
            .padding()
            .background(.thinMaterial)
            .clipShape(theme.shapes.small)
            
            if let onRetry {
                Button(action: {
                    onRetry()
                }) {
                    Text("retry")
                }
            }
            
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    SadCatErrorView(title: "talking to the moon")
}
