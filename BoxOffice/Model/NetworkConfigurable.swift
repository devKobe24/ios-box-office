//
//  NetworkConfigurable.swift
//  BoxOffice
//
//  Created by Minseong Kang on 2023/07/29.
//

import Foundation

public protocol NetworkConfigurable {
    var baseURL: String { get }
    var queryParameters: [String: String] { get }
}

extension NetworkConfigurable {
    public func urlRequestGenerate() throws -> URLRequest {
        var urlQueryItems: [URLQueryItem] = []
        
        guard var urlComponents = URLComponents(string: baseURL) else {
            throw URLComponentError.components
        }
        
        queryParameters.forEach {
            urlQueryItems.append(URLQueryItem(name: $0.key, value: $0.value))
        }
        
        urlComponents.queryItems = urlQueryItems
        
        guard let url = urlComponents.url else {
            throw URLComponentError.convertURL
        }
        
        let requestURL = URLRequest(url: url)
        
        return requestURL
    }
    
    public func urlGenerate(paths: [String], isFullPath: Bool) throws -> URL {
        guard let url = URL(string: baseURL) else {
            throw URLGenerateError.convertURL
        }
        // "http://kobis.or.kr/"
        var baseURL = url.absoluteString
        
        paths.forEach {
            baseURL += $0
        }
        
        guard var urlComponents = URLComponents(string: baseURL) else {
            throw URLGenerateError.components
        }
        
        var urlQueryItems: [URLQueryItem] = []
        
        queryParameters.forEach {
            urlQueryItems.append(URLQueryItem(name: $0.key, value: $0.value))
        }
        
        urlComponents.queryItems = !urlQueryItems.isEmpty ? urlQueryItems : nil
        
        let fullURL = isFullPath ? URL(string: baseURL) : urlComponents.url
        
        guard let urlResult = fullURL else {
            throw URLGenerateError.convertURL
        }
        
        return urlResult
    }
}

enum URLRequestGenerateError: Error {
    case convertURL
}

enum URLComponentError: Error {
    case components
    case convertURL
}

enum URLGenerateError: Error {
    case convertURL
    case components
}
