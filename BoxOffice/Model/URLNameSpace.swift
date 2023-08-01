//
//  URLNameSpace.swift
//  BoxOffice
//
//  Created by Minseong Kang on 2023/08/01.
//

enum URLNameSpace {
    case fullPathURL
    case baseURL
    case pathOfAPI
    case pathOfwebService
    case pathOfRest
    case pathOfBoxOffice
    case pathOfSearchDailyBoxOfficeJSON
    
    var rawValue: String {
        switch self {
        case .fullPathURL:
            return "http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=f5eef3421c602c6cb7ea224104795888&targetDt=20120101"
        case .baseURL:
            return "http://kobis.or.kr"
        case .pathOfAPI:
            return "/kobisopenapi"
        case .pathOfwebService:
            return "/webservice"
        case .pathOfRest:
            return "/rest"
        case .pathOfBoxOffice:
            return "/boxoffice"
        case .pathOfSearchDailyBoxOfficeJSON:
            return "/searchDailyBoxOfficeList.json"
        
        }
    }
}
