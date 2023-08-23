//
//  NetworkConfigurable.swift
//  BoxOffice
//
//  Created by Minseong Kang on 2023/08/18.
//

import Foundation

public protocol NetworkConfigurable {
    var baseURL: String { get }
    var queryItems: [String: String]? { get set }
    var headerParameters: [String: String]? { get }
}
