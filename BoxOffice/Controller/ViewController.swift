//
//  ViewController.swift
//  BoxOffice
//
//  Created by kjs on 13/01/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        do {
            let networkManager = NetworkManager()
            let requestURL = try networkManager.makeURLRequest(
                baseURL: "http://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieInfo.json?",
                queryItems: [
                    URLQueryItem(name: "key", value: "d4bb1f8d42a3b440bb739e9d49729660"),
                    URLQueryItem(name: "movieCd", value: "20124079")
                ]
            )
//            let requestURL = try networkManager.makeURLRequest(
//                baseURL: "http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?",
//                queryItems: [
//                    URLQueryItem(name: "key", value: "d4bb1f8d42a3b440bb739e9d49729660"),
//                    URLQueryItem(name: "targetDt", value: "20230724"),
//                    URLQueryItem(name: "itemPerPage", value: "10"),
//                    URLQueryItem(name: "multiMovieYn", value: nil),
//                    URLQueryItem(name: "repNationCd", value: nil),
//                    URLQueryItem(name: "wideAreaCd", value: nil)
//                ]
//            )
//            networkManager.fetchData(requestURL: requestURL, sessionConfiguration: .default) { (boxOffice: BoxOffice) in
//                print(boxOffice)
//            }
            networkManager.fetchData(
                requestURL: requestURL,
                sessionConfiguration: .default) { (individualMovieDetailInfomation: IndividualMovieDetailInfomation) in
                print("individualMovieDetailInfomation: \(individualMovieDetailInfomation)")
            }
        } catch {
            print(error.localizedDescription)
        }
        
    }
}

