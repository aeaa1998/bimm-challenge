//
//  Date+Utils.swift
//  BIMM
//
//  Created by Augusto Alonso on 8/02/24.
//

import Foundation


extension Date {
    func formatted(dateStyle: DateFormatter.Style, timeStyle: DateFormatter.Style, using locale: Locale = Locale.current) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = dateStyle
        dateFormatter.timeStyle = timeStyle
        dateFormatter.locale = locale
        return dateFormatter.string(from: self)
    }
}
