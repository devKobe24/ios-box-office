//
//  MovieInformationItem.swift
//  BoxOffice
//
//  Created by Minseong Kang on 2023/08/23.
//

import Foundation

struct MovieInformationItem: Hashable {
    
    let movieCode: String?
    let showTime: String?
    let productionYear: String?
    let openDate: String?
    let productionNations: String?
    let genres: String?
    let directors: String?
    let audits: String?
    
    init(
        movieCode: String? = nil,
        showTime: String? = nil,
        productionYear: String? = nil,
        openDate: String? = nil,
        productionNations: String? = nil,
        genres: String? = nil,
        directors: String? = nil,
        audits: String? = nil
    ) {
        self.movieCode = movieCode
        self.showTime = showTime
        self.productionYear = productionYear
        self.openDate = openDate
        self.productionNations = productionNations
        self.genres = genres
        self.directors = directors
        self.audits = audits
    }
    private let identifier = UUID()
}
