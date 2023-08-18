//
//  MoviePoster.swift
//  BoxOffice
//
//  Created by by Kobe, yyss99 on 2023/08/16.
//

import Foundation

struct MoviePoster: Hashable {
    let imageUrl: String?
    
    init(imageUrl: String? = nil) {
        self.imageUrl = imageUrl
    }
    
    static var moviePosterImageURLs: [MoviePoster] = []
}
