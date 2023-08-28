//
//  KobisAPIDataGettable.swift
//  BoxOffice
//
//  Created by Minseong Kang on 2023/08/27.
//

import Foundation

protocol KobisAPIDataGettable {
    var baseURL: String { get }
    var path: String { get }
    //MARK: - NetworkConfiguer 보고 리팩토링해보자.queryItems 처럼
    var queries: [URLQueryItem] { get }
}
