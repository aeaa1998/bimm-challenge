//
//  String+Dates.swift
//  BIMM
//
//  Created by Augusto Alonso on 8/02/24.
//

import Foundation

import Foundation
extension String {    
    func toDate(withFormat dateFormat: DateFormat = .iso8601, using locale: Locale? = .current) -> Date {
        let formater = DateFormatter()
        formater.dateFormat = dateFormat.value
        if let locale = locale {
            formater.locale = locale
        }
        let dateHolder = formater.date(from: self)
        guard let date = dateHolder else{
            return Date()
        }
        
        return date
    }
    
    
    func toZonedDate(dateFormat: DateFormat = .iso8601, locale: Locale = .current, tz: TimeZone = .current) -> Date {
        let formater = DateFormatter()
        formater.dateFormat = dateFormat.value
        formater.locale = locale
        formater.timeZone = tz
        let dateHolder = formater.date(from: self)
        guard let date = dateHolder else{
            return Date()
        }
        
        return date
    }

}


