//
//  CatDetailTalkView.swift
//  BIMM
//
//  Created by Augusto Alonso on 9/02/24.
//

import SwiftUI

struct CatDetailTalkView: View {
    @Environment(\.theme) var theme
    @Environment(\.colorScheme) var colorScheme
    let id: String
    @State var talk: String = ""
    @State var textToShow: String = ""
    
    private let imageHeight: CGFloat = 250
    
    private var isDisabled: Bool {
        talk.isEmpty
    }
    
    var body: some View {
        VStack(spacing: 10) {
            Text("cat_talk_instructions")
                .font(.subheadline)
            
            HStack {
                UnderlineTextFieldView("cat_talk_placeholder", text: $talk)
                    
                
                Button(action: {
                    textToShow = talk
                    hideKeyboard()
                }){
                    Image(systemName: "checkmark")
                }
                .disabled(isDisabled)
                .bold()
                .iconButtonStyle(with: Color.green)
                .accessibilityLabel("show_cat_talking")
                
                
                Button(action: {
                    textToShow = ""
                    talk = ""
                }){
                    Image(systemName: "xmark")
                }
                .disabled(isDisabled)
                .bold()
                .iconButtonStyle(with: Color.red)
                .accessibilityLabel("hide_cat_talking")
            }
            
            if(!textToShow.isEmpty) {
                CatImageView(
                    id: id,
                    talk: textToShow,
                    queryParameters: ["fontSize": "22", "height": imageHeight.description, "width": imageHeight.description]
                )
                    .frame(width: imageHeight, height: imageHeight)
                    .background(.thickMaterial)
                    .padding(.top)
            }
        }
        .scrollDismissesKeyboard(.immediately)
    }
}

#Preview {
    CatDetailTalkView(id: "JYpbBMDo6Hexm6OB")
        .preferredColorScheme(.dark)
}
