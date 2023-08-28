//
//  NetworkError.swift
//  BoxOffice
//
//  Created by Kobe, yyss99 on 2023/08/01.
//

import Foundation

enum NetworkError: LocalizedError {
    case urlComponents
    case url
    case urlResult
    case requestFailed
    case invalidResponse
    case emptyData
}
