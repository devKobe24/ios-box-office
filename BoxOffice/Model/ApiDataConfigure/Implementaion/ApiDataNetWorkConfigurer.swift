//
//  ApiDataNetWorkConfigurer.swift
//  BoxOffice
//
//  Created by Minseong Kang on 2023/08/18.
//

import Foundation

struct ApiDataNetWorkConfigurer: ApiDataConfigurable {
    public var baseURL: URL
    public var headers: [String : String]
    public var queryParameters: [String: String]
    
    public init(baseURL: URL,
                headers: [String : String],
                queryParameters: [String : String]) {
        self.baseURL = baseURL
        self.headers = headers
        self.queryParameters = queryParameters
    }
}
