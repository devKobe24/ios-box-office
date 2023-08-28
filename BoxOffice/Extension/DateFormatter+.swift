//
//  DateFormatter+.swift
//  BoxOffice
//
//  Created by Kobe, yyss99 on 2023/08/11.
//

import Foundation

extension DateFormatter {
    func changeDateFormat(_ date: Date, _ format: DateFormat) throws -> String {
        self.dateFormat = format.rawValue
        
        return self.string(from: date)
    }
    
    func changeDateFormat(with date: Date, format: DateFormat) throws -> Date {
        self.dateFormat = format.rawValue
        let dateString = self.string(from: date)
        guard let returnDateValue = self.date(from: dateString) else {
            throw DateError.format
        }
        return returnDateValue
    }
}

extension DateFormatter {
    enum DateFormat: String {
        case hyphen = "yyyy-MM-dd"
        case attached = "yyyyMMdd"
    }
}
