//
//  String+Localizable.swift
//  BIMM
//
//  Created by Augusto Alonso on 8/02/24.
//

import Foundation
import SwiftUI

extension String {
    func localized() -> LocalizedStringKey {
        LocalizedStringKey(self)
    }
}
