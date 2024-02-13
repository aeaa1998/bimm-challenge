//
//  HidesKeyboardToolBarItemViewModifier.swift
//  BIMM
//
//  Created by Augusto Alonso on 12/02/24.
//

import SwiftUI

struct HidesKeyboardToolBarItemViewModifier : ViewModifier {
    func body(content: Content) -> some View {
        content
            .toolbar{
                ToolbarItem(placement: .keyboard) {
                    Button(action: {
                        hideKeyboard()
                    }){
                        Text("done")
                    }
                }
            }
    }
}


extension View {
    func addKeyboardDismissAction() -> some View {
        self.modifier(HidesKeyboardToolBarItemViewModifier())
    }
}
