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
