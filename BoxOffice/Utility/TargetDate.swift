//
//  TargetDate.swift
//  BoxOffice
//
//  Created by Minseong Kang on 2023/08/25.
//

import Foundation

struct TargetDate {
    private let dayFromNow: Int
    private let dayToSecond: TimeInterval
    private let oneDayToSecond: Double = 86400
    private let dateFormatter = DateFormatter()
    
    init(dayFromNow: Int) {
        self.dayFromNow = dayFromNow
        self.dayToSecond = TimeInterval(dayFromNow) * oneDayToSecond
    }
    
    func formattedWithHyphen() -> String {
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        return dateFormatter.string(from: Date(timeIntervalSinceNow: dayToSecond))
    }
    
    func formattedWithoutSeparator() -> String {
        dateFormatter.dateFormat = "yyyyMMdd"
        
        return dateFormatter.string(from: Date(timeIntervalSinceNow: dayToSecond))
    }
}
