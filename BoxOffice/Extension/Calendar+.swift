//
//  Calendar+.swift
//  BoxOffice
//
//  Created by Minseong Kang on 2023/08/27.
//

import Foundation

extension Calendar {
    func targetDt() throws -> String {
        let currentCalendar = Calendar.current
        let dateFormatter = DateFormatter()
        var targetDt: String?
        do {
            let currentDate = try dateFormatter.changeDateFormat(
                with: Date(),
                format: DateFormatter.DateFormat.attached
            )
            
            guard let yesterdayDate = currentCalendar.date(
                byAdding: .day,
                value: -1,
                to: currentDate
            ) else {
                throw DateError.fetchDate
            }
            
            let yesterday = dateFormatter.string(from: yesterdayDate)
            
            targetDt = yesterday
        } catch {
            print(error.localizedDescription)
        }
        guard let targetDt = targetDt else {
            throw DateError.emptyDate
        }
        return targetDt
    }
}
