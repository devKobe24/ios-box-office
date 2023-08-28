//
//  KakaoAPIDataGetter.swift
//  BoxOffice
//
//  Created by Minseong Kang on 2023/08/24.
//

import Foundation

enum KakaoAPIDataGetter {
    case image(keyword: String)
}

extension KakaoAPIDataGetter: KakaoAPIDataGettable {
    var baseURL: String {
        return "https://dapi.kakao.com"
    }
    
    var path: String {
        var pathString = "/v2/search/"
        
        switch self {
        case .image:
            pathString += "image"
        }
        return pathString
    }
    
    var queries: [URLQueryItem] {
        switch self {
        case .image(let keyword):
            return [URLQueryItem(name: "query", value: keyword)]
        }
    }
    
    var urlRequest: URLRequest? {
        guard let url = URL(baseURL, path, queries) else { return nil }
        
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = "GET"
        urlRequest.addValue("KakaoAK 3072c89de6f543ff508009a001ea12d9", forHTTPHeaderField: "Authorization")
        
        return urlRequest
    }
    
    var urlAbsoluteString: String? {
        guard let url = URL(baseURL, path, queries) else { return nil }
        
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = "GET"
        urlRequest.addValue("KakaoAK 3072c89de6f543ff508009a001ea12d9", forHTTPHeaderField: "Authorization")
        
        let urlAbsoluteString = url.absoluteString
        
        return urlAbsoluteString
    }
}
