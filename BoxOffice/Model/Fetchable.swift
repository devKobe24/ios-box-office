//
//  Fetchable.swift
//  BoxOffice
//
//  Created by Minseong Kang on 2023/08/15.
//

protocol Fetchable {
    var baseULR: String { get set }
    var queryItems: [String: String] { get set }
    func fetchBoxOfficeData(completion: @escaping () -> ())
}

extension Fetchable {
    func fetchBoxOfficeData(completion: @escaping () -> ()) {
        do {
            let endPoint = EndPoint(
                baseURL: "http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json",
                queryItems: [
                    "key": "d4bb1f8d42a3b440bb739e9d49729660",
                    "targetDt": "\(dateCountUpForTest)"
                ]
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
