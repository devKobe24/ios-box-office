//
//  DataError.swift
//  BoxOffice
//
//  Created by Minseong Kang on 2023/08/27.
//

import Foundation

enum DataError: LocalizedError {
    case invalidAsset
    case failedDecoding
    
    var errorDescription: String? {
        switch self {
        case .invalidAsset:
            return "유효하지 않은 에셋 파일입니다. 데이터를 찾을 수 없습니다."
        case .failedDecoding:
            return "디코딩에 실패했습니다."
        }
    }
}
