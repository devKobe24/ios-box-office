//
//  DateError.swift
//  BoxOffice
//
//  Created by Minseong Kang on 2023/08/27.
//

import Foundation

enum DateError: LocalizedError {
    case format
    case fetchDate
    case emptyDate
    
    var errorDescription: String? {
        switch self {
        case .format:
            return "날짜 포맷팅에 실패하였습니다."
        case .fetchDate:
            return "날짜 데이터를 가져오는데 실패하였습니다."
        case .emptyDate:
            return "날짜 데이터가 nil입니다."
        }
    }
}
