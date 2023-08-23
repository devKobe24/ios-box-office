//
//  MovieInformationDataError.swift
//  BoxOffice
//
//  Created by Minseong Kang on 2023/08/22.
//

import Foundation

enum MovieInformationDataError: LocalizedError {
    case unwrapFailed
    case decodeFailed
    
    var errorDescription: String? {
        switch self {
        case .decodeFailed:
            return "데이터 디코딩에 실패하였습니다."
        case .unwrapFailed:
            return "데이터 언래핑에 실패하였습니다."
        }
    }
}
