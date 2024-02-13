//
//  ThemeEnvironmentKey.swift
//  BIMM
//
//  Created by Augusto Alonso on 12/02/24.
//

import SwiftUI

private struct ThemeEnvironmentKey : EnvironmentKey {
    static let defaultValue: Theme = BIMMTheme.default
}


extension EnvironmentValues {
    var theme: Theme {
        get { self[ThemeEnvironmentKey.self] }
        set { self[ThemeEnvironmentKey.self] = newValue }
    }
}

extension View {
    func setTheme(_ theme: Theme) -> some View {
        environment(\.theme, theme)
    }
}
