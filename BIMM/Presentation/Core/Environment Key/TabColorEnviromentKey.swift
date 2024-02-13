//
//  TabColorEnviromentKey.swift
//  BIMM
//
//  Created by Augusto Alonso on 9/02/24.
//

import Foundation
import SwiftUI

private struct TabColorEnviromentKey: EnvironmentKey {
    static let defaultValue: Color? = nil
}

extension EnvironmentValues {
    var tabColor: Color? {
        get { self[TabColorEnviromentKey.self] }
        set { self[TabColorEnviromentKey.self] = newValue }
    }
}

extension View {
    func tabColor(_ color: Color) -> some View {
        environment(\.tabColor, color)
    }
}
