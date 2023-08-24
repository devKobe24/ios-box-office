//
//  URL+.swift
//  BoxOffice
//
//  Created by Minseong Kang on 2023/08/24.
//

import Foundation

extension URL {
    init?(_ baseURL: String, _ path: String, _ queries: [URLQueryItem]) {
        var urlComponents = URLComponents(string: baseURL)
        urlComponents?.path = path
        urlComponents?.queryItems = queries
        
        guard let url = urlComponents?.url else {
            return nil
        }
        
        self = url
    }
}
