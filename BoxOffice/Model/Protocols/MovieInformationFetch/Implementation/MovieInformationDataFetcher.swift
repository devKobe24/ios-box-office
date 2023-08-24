//
//  MovieInformationDataFetcher.swift
//  BoxOffice
//
//  Created by Minseong Kang on 2023/08/23.
//

import Foundation

final class MovieInformationDataFetcher: MovieInformationDataFetchable {
    var baseURL: String
    var queryItems: [String : String]?
    var headerParameters: [String : String]?
    
    
    init(
        baseURL: String,
        queryItems: [String: String]? = nil,
        headerParameters: [String: String]? = nil
    ) {
        self.baseURL = baseURL
        self.queryItems = queryItems
        self.headerParameters = headerParameters
    }
    
    func fetchMoviewInformationData(
        networkManager: NetworkManager?,
        queryParameters: [String: String]?,
        completion: @escaping (Result<MovieInformation?, Error>) -> Void)
    {
        queryParameters?.forEach({ (key, value) in
            self.queryItems = [key: value]
        })
        
        do {
            let networkConfigurer = NetworkConfigurer(
                baseURL: baseURL,
                queryItems: queryParameters,
                headerParameters: headerParameters
            )
            
            let url = try networkConfigurer.generateURL(isFullPath: false)
            
            let urlRequest = URLRequest(url: url)
            
            networkManager?.getData(requestURL: urlRequest, completionHandler: { (movieInformation: MovieInformation) in
                completion(.success(movieInformation))
            })
        } catch {
            completion(.failure(error))
        }
    }
    
    func fetchMovieInfomationItem(
        networkManager: NetworkManager?,
        queryParameters: [String: String]?,
        completion: @escaping (Result<MovieInformationItem?, Error>) -> Void)
    {
        queryParameters?.forEach({ (key, value) in
            self.queryItems = [key: value]
        })
        
        do {
            let networkConfigurer = NetworkConfigurer(
                baseURL: baseURL,
                queryItems: queryParameters,
                headerParameters: headerParameters
            )
            
            let url = try networkConfigurer.generateURL(isFullPath: false)
            
            let urlRequest = URLRequest(url: url)
            
            networkManager?.getData(requestURL: urlRequest, completionHandler: { (movieInformation: MovieInformation) in
                let movieCode = movieInformation.movieCode
                let showTime = movieInformation.showTime
                let productYear = movieInformation.productionYear
                let openDate = movieInformation.openDate
                let productNation = movieInformation.productionNations[0].productionNations
                let genre = movieInformation.genres[0].genreName
                let directorName = movieInformation.directors[0].directorName
                let audits = movieInformation.audits[0].watchGradeName
                
                let movieInformationItem = MovieInformationItem(
                    movieCode: movieCode,
                    showTime: showTime,
                    productionYear: productYear,
                    openDate: openDate,
                    productionNations: productNation,
                    genres: genre,
                    directors: directorName,
                    audits: audits
                )
                
                completion(.success(movieInformationItem))
            })
        } catch {
            completion(.failure(error))
        }
    }
}
