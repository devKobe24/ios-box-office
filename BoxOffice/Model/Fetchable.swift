//
//  Fetchable.swift
//  BoxOffice
//
//  Created by Minseong Kang on 2023/08/09.
//

import UIKit

protocol Fetchable: AnyObject {
    var boxOfficeData: [BoxOffice] { get set }
    var itemData: [Item] { get set }
    var networkManager: NetworkManager { get }
}

extension Fetchable {
    func fetchBoxOfficeData(completion: @escaping ([Item]) -> ()) {
        do {
            let endPoint: EndPoint = EndPoint(
                baseURL: "http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json",
                queryItems: [
                    "key": "d4bb1f8d42a3b440bb739e9d49729660",
                    "targetDt": "20230724"
                ]
            )
            
            let url = try endPoint.generateURL(
                isFullPath: false
            )
            
            let urlRequest = URLRequest(url: url)
            
            networkManager.getBoxOfficeData(requestURL: urlRequest) { [weak self] (boxOffice: BoxOffice) in
                guard let self = self else { return }
                
                self.boxOfficeData.append(boxOffice)
                let count = boxOffice.boxOfficeResult.dailyBoxOfficeList.count
                for index in 1...count {
                    print(index-1)
                    let rankNumber = boxOffice.boxOfficeResult.dailyBoxOfficeList[index-1].rankNumber
                    let rankIntensity = boxOffice.boxOfficeResult.dailyBoxOfficeList[index-1].rankIntensity
                    let movieName = boxOffice.boxOfficeResult.dailyBoxOfficeList[index-1].movieName
                    let audienceCount = boxOffice.boxOfficeResult.dailyBoxOfficeList[index-1].audienceCount
                    let audienceAccumulated = boxOffice.boxOfficeResult.dailyBoxOfficeList[index-1].audienceAccumulated
                    
                    let items = Item(rankNumber: rankNumber, rankIntensity: rankIntensity, movieName: movieName, audienceCount: audienceCount, audienceAccumulated: audienceAccumulated)
                    
                    self.itemData.append(items)
                }
                completion(self.itemData)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}
