//
//  FetchDateble.swift
//  BoxOffice
//
//  Created by Minseong Kang on 2023/08/11.
//

import Foundation

protocol FetchDateble {
    
}

extension FetchDateble {
    func fetchDate() -> String {
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let fetchDate = dateFormatter.string(from: currentDate)
        
        return fetchDate
    }
}
