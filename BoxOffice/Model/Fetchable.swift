//
//  Fetchable.swift
//  BoxOffice
//
//  Created by Minseong Kang on 2023/08/15.
//

import Foundation

protocol Fetchable: AnyObject, NetworkConfigurable {
//    func fetchBoxOfficeData(networkManager: NetworkManager, queryParameters: [String: String], completion: @escaping () -> ())
}

extension Fetchable {
    func fetchBoxOfficeData(networkManager: NetworkManager, queryParameters: [String: String], completion: @escaping () -> ()) {
        
        queryParameters.forEach { [weak self] (key, value) in
            self?.queryItems = [key: value]
        }
        
        do {
            let endPoint = EndPoint(
                headerParameters: [:],
                baseURL: baseURL,
                queryItems: queryParameters
            )
            
            let url = try endPoint.generateURL(isFullPath: false)
            
            let urlRequest = URLRequest(url: url)
    
            networkManager.getBoxOfficeData(requestURL: urlRequest) { (boxOffice: BoxOffice) in
                let count = boxOffice.boxOfficeResult.dailyBoxOfficeList.count
                for index in 0...(count-1) {
                    let rankNumber = boxOffice.boxOfficeResult.dailyBoxOfficeList[index].rankNumber
                    let rankIntensity = boxOffice.boxOfficeResult.dailyBoxOfficeList[index].rankIntensity
                    let movieName = boxOffice.boxOfficeResult.dailyBoxOfficeList[index].movieName
                    let audienceCount = boxOffice.boxOfficeResult.dailyBoxOfficeList[index].audienceCount
                    let audienceAccumulated = boxOffice.boxOfficeResult.dailyBoxOfficeList[index].audienceAccumulated
                    let rankOldAndNew = boxOffice.boxOfficeResult.dailyBoxOfficeList[index].rankOldAndNew
                    
                    let items = Item(rankNumber: rankNumber, rankIntensity: rankIntensity, movieName: movieName, audienceCount: audienceCount, audienceAccumulated: audienceAccumulated, rankOldAndNew: rankOldAndNew)
                    
                    Item.all.append(items)
                }
                completion()
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}

extension Fetchable {
    func fetchMoviePoster(networkManager: NetworkManager, headers: [String: String] ,queryParameters: [String: String], completion: @escaping (String) -> ()) {
        queryParameters.forEach { [weak self] (key, value) in
            self?.queryItems = [key: value]
        }
        
        do {
            let endPoint = EndPoint(
                headerParameters: headers,
                baseURL: baseURL,
                queryItems: queryParameters
            )
            
            let url = try endPoint.generateURL(isFullPath: false)
            let config = ApiDataNetWorkConfig(baseURL: url, headers: headers, queryParameters: queryParameters)
            let urlRequest = try generateURLRequest(config: config)
            
            networkManager.getBoxOfficeData(requestURL: urlRequest) { (moviePoster: KakaoImageSearchResult) in
                let count = moviePoster.documents.count
                for index in 0...(count-1) {
                    let moviePostersURLs = moviePoster.documents[index].imageUrl
                    
                    MoviePoster.moviePosterImageURLs.append(MoviePoster(imageUrl: moviePostersURLs))
                    
                }
                guard let moviePoster = MoviePoster.moviePosterImageURLs[0].imageUrl else { return }
                completion(moviePoster)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}
