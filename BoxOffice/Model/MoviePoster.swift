//
//  MoviePoster.swift
//  BoxOffice
//
//  Created by Minseong Kang on 2023/08/15.
//

import Foundation

struct MoviePoster: Hashable {
    let imageUrl: String?
    
    init(imageUrl: String? = nil) {
        self.imageUrl = imageUrl
    }
    
    static var moviePosterImageURLs: [MoviePoster] = []
}
