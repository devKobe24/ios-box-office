//
//  BoxOfficeDataFetcher.swift
//  BoxOffice
//
//  Created by Minseong Kang on 2023/08/18.
//

import Foundation


final class BoxOfficeDataFetcher: BoxOffiecDataFetchable {
    
    func fetchBoxOfficeData(
        with targetDate: String,
        completion: @escaping (Result<[DailyBoxOfficeList]?, Error>) -> Void
    ) {
        
        let networkManager: NetworkManager = NetworkManager()
        let kobisAPIGetter: KobisAPIDataGetter = .boxOffice(targetDate)
        
        guard let url = kobisAPIGetter.url else {
            return
        }
        
        networkManager.fetchData(with: url) { result in
            do {
                guard let data = try result.get() else {
                    return
                }
                
                let decodedData = try JSONDecoderProtocol.decodeJSON(
                    type: BoxOffice.self,
                    data: data
                )
                
                let boxOfficeItems = decodedData.boxOfficeResult.dailyBoxOfficeList
                
                completion(.success(boxOfficeItems))
            } catch {
                completion(.failure(error))
            }
        }
    }
}


//final class BoxOfficeDataFetcher: BoxOffiecDataFetchable {
//    var baseURL: String
//    var queryItems: [String : String]?
//    var headerParameters: [String : String]?
//
//    init(
//        baseURL: String,
//        queryItems: [String : String]? = nil,
//        headerParameters: [String : String]? = nil
//    ) {
//        self.baseURL = baseURL
//        self.queryItems = queryItems
//        self.headerParameters = headerParameters
//    }
//
//    func appendBoxOfficeDataToItem(
//        networkManager: NetworkManager?,
//        queryParameters: [String: String]?,
//        completion: @escaping () -> Void
//    ) {
//        queryParameters?.forEach { (key, value) in
//            self.queryItems = [key: value]
//        }
//
//        do {
//            let networkConfigurer = NetworkConfigurer(
//                baseURL: baseURL,
//                queryItems: queryParameters
//            )
//
//            let url = try networkConfigurer.generateURL(isFullPath: false)
//
//            let urlRequest = URLRequest(url: url)
//
//            networkManager?.getData(requestURL: urlRequest) { (boxOffice: BoxOffice) in
//                let count = boxOffice.boxOfficeResult.dailyBoxOfficeList.count
//                for index in 0...(count-1) {
//                    let rankNumber = boxOffice.boxOfficeResult.dailyBoxOfficeList[index].rankNumber
//                    let rankIntensity = boxOffice.boxOfficeResult.dailyBoxOfficeList[index].rankIntensity
//                    let movieName = boxOffice.boxOfficeResult.dailyBoxOfficeList[index].movieName
//                    let audienceCount = boxOffice.boxOfficeResult.dailyBoxOfficeList[index].audienceCount
//                    let audienceAccumulated = boxOffice.boxOfficeResult.dailyBoxOfficeList[index].audienceAccumulated
//                    let rankOldAndNew = boxOffice.boxOfficeResult.dailyBoxOfficeList[index].rankOldAndNew
//                    let movieCode = boxOffice.boxOfficeResult.dailyBoxOfficeList[index].movieCode
//
//                    let items = Item(rankNumber: rankNumber, rankIntensity: rankIntensity, movieName: movieName, audienceCount: audienceCount, audienceAccumulated: audienceAccumulated, rankOldAndNew: rankOldAndNew, movieCode: movieCode)
//
//                    Item.all.append(items)
//                }
//                completion()
//            }
//        } catch {
//            print(error.localizedDescription)
//        }
//    }
//
//    func fetchDataBoxOfficeData(
//        networkManager: NetworkManager?,
//        queryParameters: [String: String]?,
//        completion: @escaping (Result<Item?, Error>) -> Void)
//    {
//        queryParameters?.forEach { (key, value) in
//            self.queryItems = [key: value]
//        }
//
//        do {
//            let networkConfigurer = NetworkConfigurer(
//                baseURL: baseURL,
//                queryItems: queryParameters
//            )
//
//            let url = try networkConfigurer.generateURL(isFullPath: false)
//
//            let urlRequest = URLRequest(url: url)
//
//            networkManager?.getData(requestURL: urlRequest) { (boxOffice: BoxOffice) in
//                let count = boxOffice.boxOfficeResult.dailyBoxOfficeList.count
//                for index in 0...(count-1) {
//                    let rankNumber = boxOffice.boxOfficeResult.dailyBoxOfficeList[index].rankNumber
//                    let rankIntensity = boxOffice.boxOfficeResult.dailyBoxOfficeList[index].rankIntensity
//                    let movieName = boxOffice.boxOfficeResult.dailyBoxOfficeList[index].movieName
//                    let audienceCount = boxOffice.boxOfficeResult.dailyBoxOfficeList[index].audienceCount
//                    let audienceAccumulated = boxOffice.boxOfficeResult.dailyBoxOfficeList[index].audienceAccumulated
//                    let rankOldAndNew = boxOffice.boxOfficeResult.dailyBoxOfficeList[index].rankOldAndNew
//                    let movieCode = boxOffice.boxOfficeResult.dailyBoxOfficeList[index].movieCode
//
//                    let items = Item(rankNumber: rankNumber, rankIntensity: rankIntensity, movieName: movieName, audienceCount: audienceCount, audienceAccumulated: audienceAccumulated, rankOldAndNew: rankOldAndNew, movieCode: movieCode)
//
//                    Item.all.append(items)
//                    completion(.success(items))
//                }
//            }
//        } catch {
//            completion(.failure(error))
//        }
//    }
//}
