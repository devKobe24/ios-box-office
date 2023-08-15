//
//  KakaoImageSearchResult.swift
//  BoxOffice
//
//  Created by Minseong Kang on 2023/08/15.
//

import Foundation

struct KakaoImageSearchResult: Decodable, Hashable {
    let documents: [Documents]
}

struct Documents: Decodable, Hashable {
    let imageUrl: String
    
    private enum CodingKeys: String, CodingKey {
        case imageUrl = "image_url"
    }
}
