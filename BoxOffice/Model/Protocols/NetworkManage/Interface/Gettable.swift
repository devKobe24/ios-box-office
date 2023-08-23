//
//  Gettable.swift
//  BoxOffice
//
//  Created by Minseong Kang on 2023/08/19.
//

import Foundation

public protocol Gettable {
    func getData<T: Decodable>(requestURL: URLRequest, completionHandler: @escaping (T) -> Void)
}
