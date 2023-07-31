//
//  Requestable.swift
//  BoxOffice
//
//  Created by Minseong Kang on 2023/07/29.
//

import Foundation

public protocol Requestable: NetworkConfigurable {
    var path: String { get }
    var isFullPath: Bool { get }
    var queryParameters: [String: String] { get }
}

extension Requestable {
  
}


