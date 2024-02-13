//
//  View+Utils.swift
//  BIMM
//
//  Created by Augusto Alonso on 9/02/24.
//

import SwiftUI

func getWindow() -> UIWindow? {
    return UIApplication.shared.connectedScenes

        .filter({$0.activationState == .foregroundActive})

        .map({$0 as? UIWindowScene})

        .compactMap({$0})

        .first?.windows

        .filter({$0.isKeyWindow}).first
}

func getSafeAreaTop() -> CGFloat? {

    let keyWindow = getWindow()

    return (keyWindow?.safeAreaInsets.top)

}

func hideKeyboard() {
    getWindow()?.endEditing(true)

}
