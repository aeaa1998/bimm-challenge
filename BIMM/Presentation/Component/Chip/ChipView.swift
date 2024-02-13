//
//  ChipView.swift
//  BIMM
//
//  Created by Augusto Alonso on 8/02/24.
//

import SwiftUI

struct ChipView<Content: View>: View {
    
    let size: Size
    let content: Content
    
    init(
        size: Size = .small,
        content: @escaping () -> Content
    ) {
        self.content = content()
        self.size = size
    }
    
    var body: some View {
        content
            .padding(.vertical, size.verticalPadding)
            .padding(.horizontal, size.horizontalPadding)
    }
    
    enum Size {
        case small, medium, large, custom(x: CGFloat, y: CGFloat)
        
        fileprivate var horizontalPadding: CGFloat {
            switch self {
            case .small:
                return 6
            case .medium:
                return 10
            case .large:
                return 14
            case .custom(x: let x, y: _):
                return x
            }
        }
        
        fileprivate var verticalPadding: CGFloat {
            switch self {
            case .small:
                return 5
            case .medium:
                return 8
            case .large:
                return 12
            case .custom(x: _, y: let y):
                return y
            }
        }
    }
}


extension ChipView where Content == Text {
    init(_ text: String, size: Size = .small) {
        self.content = Text(text)
        self.size = size
    }
}

#Preview {
    ChipView("text")
        .background(BIMMTheme.default.palette.primary)
}
