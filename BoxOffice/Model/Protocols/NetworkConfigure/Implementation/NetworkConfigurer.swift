//
//  NetworkConfigurer.swift
//  BoxOffice
//
//  Created by Minseong Kang on 2023/08/18.
//

import Foundation

struct NetworkConfigurer: NetworkConfigurable {
    
    var baseURL: String
    var queryItems: [String : String]?
    var headerParameters: [String : String]?
    
    init(baseURL: String,
         queryItems: [String : String]? = nil,
         headerParameters: [String : String]? = nil
    ) {
        self.baseURL = baseURL
        self.queryItems = queryItems
        self.headerParameters = headerParameters
    }
    
    public func generateURLRequest(config: NetworkConfigurable) throws -> URLRequest {
        var urlQureyItems: [URLQueryItem] = []
        
        var allHeaders: [String: String]? = config.headerParameters
        headerParameters?.forEach({ allHeaders?.updateValue($1, forKey: $0) })
        
        guard var urlComponents = URLComponents(string: baseURL) else {
            throw NetworkError.urlComponents
        }
        
        queryItems?.forEach {
            urlQureyItems.append(URLQueryItem(name: $0.key, value: $0.value))
        }
        
        urlComponents.queryItems = urlQureyItems
        
        guard let url = urlComponents.url else {
            throw NetworkError.url
        }
        
        var requestURL = URLRequest(url: url)
        requestURL.allHTTPHeaderFields = allHeaders
        
        return requestURL
    }
    
    public func generateURL(isFullPath: Bool) throws -> URL {
        guard let url = URL(string: baseURL) else {
            throw NetworkError.url
        }
        
        let baseURL = url.absoluteString
        
        guard var urlComponents = URLComponents(string: baseURL) else {
            throw NetworkError.urlComponents
        }
        
        var urlQureyItems: [URLQueryItem] = []
        
        queryItems?.forEach {
            urlQureyItems.append(URLQueryItem(name: $0.key, value: $0.value))
        }
        
        urlComponents.queryItems = !urlQureyItems.isEmpty ? urlQureyItems : nil
        
        let fullPathURL = isFullPath ? URL(string: baseURL) : urlComponents.url
        
        guard let urlResult = fullPathURL else {
            throw NetworkError.urlResult
        }
        
        return urlResult
    }
}
