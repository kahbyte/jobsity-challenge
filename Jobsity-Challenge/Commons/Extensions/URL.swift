//
//  URL.swift
//  Jobsity-Challenge
//
//  Created by Kauê Sales on 03/03/24.
//

import Foundation

extension URL {
    func appendingQueryItem(name: String, value: String) -> URL? {
        var components = URLComponents(url: self, resolvingAgainstBaseURL: false)
        let queryItem = URLQueryItem(name: name, value: value)
        
        if components?.queryItems != nil {
            components?.queryItems?.append(queryItem)
        } else {
            components?.queryItems = [queryItem]
        }
        
        return components?.url
    }
}
