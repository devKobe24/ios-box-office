//
//  EndPoint.swift
//  BoxOffice
//
//  Created by Minseong Kang on 2023/07/29.
//

import Foundation

public struct EndPoint: NetworkConfigurable {
    public var baseURL: String
    public var queryParameters: [String : String]?
}
