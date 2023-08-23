//
//  IndividualMovieDetailInformation.swift
//  BoxOffice
//
//  Created by by Kobe, yyss99 on 2023/08/16.
//

import Foundation

struct IndividualMovieDetailInformation: Decodable, Hashable {
    let movieInfoResult: MovieInfoResult
}

struct MovieInfoResult: Decodable, Hashable {
    let movieInfo: MovieInformation
    let source: String
}

struct MovieInformation: Decodable, Hashable {
    let movieCode: String
    let movieName: String
    let movieEnglishName: String
    let movieOriginalName: String
    let showTime: String
    let productionYear: String
    let openDate: String
    let productionStateName: String
    let movieTypeName: String
    let productionNations: [Nation]
    let genres: [Genre]
    let directors: [Directors]
    let actors: [Actor]
    let showTypes: [ShowType]
    let companys: [Company]
    let audits: [Audit]
    let staffs: [Staff]

    enum CodingKeys: String, CodingKey {
        case movieCode = "movieCd"
        case movieName = "movieNm"
        case movieEnglishName = "movieNmEn"
        case movieOriginalName = "movieNmOg"
        case showTime = "showTm"
        case productionYear = "prdtYear"
        case openDate = "openDt"
        case productionStateName = "prdtStatNm"
        case movieTypeName = "typeNm"
        case productionNations = "nations"
        case genres
        case directors
        case actors
        case showTypes
        case companys
        case audits
        case staffs
    }
}

struct Actor: Decodable, Hashable {
    let peopleName: String
    let peopleEnglishName: String
    let castName: String
    let castEnglishName: String

    enum CodingKeys: String, CodingKey {
        case peopleName = "peopleNm"
        case peopleEnglishName = "peopleNmEn"
        case castName = "cast"
        case castEnglishName = "castEn"
    }
}

struct Genre: Decodable, Hashable {
    let genreName: String

    enum CodingKeys: String, CodingKey {
        case genreName = "genreNm"
    }
}

struct Nation: Decodable, Hashable {
    let productionNations: String

    enum CodingKeys: String, CodingKey {
        case productionNations = "nationNm"
    }
}

struct Directors: Decodable, Hashable {
    let directorName: String
    let directorEnglishName: String

    enum CodingKeys: String, CodingKey {
        case directorName = "peopleNm"
        case directorEnglishName = "peopleNmEn"
    }
}

struct ShowType: Decodable, Hashable{
    let screenTypeClassification: String
    let screenTypeName: String

    enum CodingKeys: String, CodingKey {
        case screenTypeClassification = "showTypeGroupNm"
        case screenTypeName = "showTypeNm"
    }
}

struct Audit: Decodable, Hashable {
    let auditNumber: String
    let watchGradeName: String

    enum CodingKeys: String, CodingKey {
        case auditNumber = "auditNo"
        case watchGradeName = "watchGradeNm"
    }
}

struct Company: Decodable, Hashable {
    let companyCode: String
    let companyName: String
    let companyEnglishName: String
    let companyPartName: String

    enum CodingKeys: String, CodingKey {
        case companyCode = "companyCd"
        case companyName = "companyNm"
        case companyEnglishName = "companyNmEn"
        case companyPartName = "companyPartNm"
    }
}

struct Staff: Decodable, Hashable {
    let peopleName: String
    let peopleEnglishName: String
    let staffRoleName: String

    enum CodingKeys: String, CodingKey {
        case peopleName = "peopleNm"
        case peopleEnglishName = "peopleNmEn"
        case staffRoleName = "staffRoleNm"
    }
}
