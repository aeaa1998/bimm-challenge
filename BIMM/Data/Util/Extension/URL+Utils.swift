//
//  URL+Utils.swift
//  BIMM
//
//  Created by Augusto Alonso on 6/02/24.
//

import Foundation
extension URL {
    public var queryParameters: [String: String]? {
        guard
            let components = URLComponents(url: self, resolvingAgainstBaseURL: true),
            let queryItems = components.queryItems else { return nil }
        return queryItems.reduce(into: [String: String]()) { (result, item) in
            result[item.name] = item.value
        }
    }
    
    mutating func appendQueryItem(name: String, value: String?) {

           guard var urlComponents = URLComponents(string: absoluteString) else { return }

           // Create array of existing query items
           var queryItems: [URLQueryItem] = urlComponents.queryItems ??  []

           // Create query item
           let queryItem = URLQueryItem(name: name, value: value)

           // Append the new query item in the existing query items array
           queryItems.append(queryItem)

           // Append updated query items array in the url component object
           urlComponents.queryItems = queryItems

           // Returns the url from new url components
           self = urlComponents.url!
       }
}
