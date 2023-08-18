//
//  ApiDataConfigurable.swift
//  BoxOffice
//
//  Created by by Kobe, yyss99 on 2023/08/16.
//

import Foundation

public protocol ApiDataConfigurable {
    var baseURL: URL { get }
    var headers: [String: String] { get }
    var queryParameters: [String: String] { get }
}

struct ApiDataNetWorkConfig: ApiDataConfigurable {
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
