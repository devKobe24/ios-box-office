//
//  QueryParameterNameSpace.swift
//  BoxOffice
//
//  Created by Minseong Kang on 2023/08/01.
//

enum QueryParameterNameSpace {
    case key
    case keyValue
    case targetDt
    case targetDtValue
    
    var rawValue: String {
        switch self {
        case .key:
            return "key"
        case .keyValue:
            return "d4bb1f8d42a3b440bb739e9d49729660"
        case .targetDt:
           return "targetDt"
        case .targetDtValue:
            return "20230724"
        }
    }
}
