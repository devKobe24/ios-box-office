//
//  FetchDayilyBoxOfficeDataError.swift
//  BoxOffice
//
//  Created by Minseong Kang on 2023/08/18.
//

enum FetchDayilyBoxOfficeDataError: Error {
    case failToFetchItem
    case failToFetch
    
    var description: String {
        switch self {
        case .failToFetchItem:
            return "Item 구조체 all 배열 아이템을 가져오지 못했습니다."
        case .failToFetch:
            return "일일 박스오피스 데이터를 가져오지 못했습니다."
        }
    }
}
