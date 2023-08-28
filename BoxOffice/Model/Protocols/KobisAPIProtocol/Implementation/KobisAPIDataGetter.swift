//
//  KobisAPIDataGetter.swift
//  BoxOffice
//
//  Created by Minseong Kang on 2023/08/27.
//

import Foundation

enum KobisAPIDataGetter {
    case boxOffice(_ targetDate: String)
    case movieCode(_ movieCode: String)
}

extension KobisAPIDataGetter: KobisAPIDataGettable {
    var baseURL: String {
        return "http://www.kobis.or.kr"
    }
    
    var path: String {
        var pathString = "/kobisopenapi/webservice/rest/"
        
        switch self {
        case .boxOffice:
            pathString += "boxoffice/searchDailyBoxOfficeList.json"
        case .movieCode:
            pathString += "movie/searchMovieInfo.json"
        }
        
        return pathString
    }
    
    var queries: [URLQueryItem] {
        switch self {
        case .boxOffice(let targetDate):
            return [
                URLQueryItem(name: "key", value: Bundle.main.API_KEY),
                URLQueryItem(name: "targetDt", value: targetDate)
            ]
        case .movieCode(let movieCode):
            return [
                URLQueryItem(name: "key", value: Bundle.main.API_KEY),
                URLQueryItem(name: "movieCd", value: movieCode)
            ]
        }
    }
    
    var url: URL? {
        return URL(baseURL, path, queries)
    }
    
    
}
