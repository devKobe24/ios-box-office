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
        
        
//        do {
//            let networkManager = NetworkManager()
//            let requestURL = try networkManager.makeURLRequest(
//                baseURL: "http://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieInfo.json?",
//                queryItems: [
//                    URLQueryItem(name: "key", value: "d4bb1f8d42a3b440bb739e9d49729660"),
//                    URLQueryItem(name: "movieCd", value: "20124079")
//                ]
//            )
////            let requestURL = try networkManager.makeURLRequest(
////                baseURL: "http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?",
////                queryItems: [
////                    URLQueryItem(name: "key", value: "d4bb1f8d42a3b440bb739e9d49729660"),
////                    URLQueryItem(name: "targetDt", value: "20230724"),
////                    URLQueryItem(name: "itemPerPage", value: "10"),
////                    URLQueryItem(name: "multiMovieYn", value: nil),
////                    URLQueryItem(name: "repNationCd", value: nil),
////                    URLQueryItem(name: "wideAreaCd", value: nil)
////                ]
////            )
////            networkManager.fetchData(requestURL: requestURL, sessionConfiguration: .default) { (boxOffice: BoxOffice) in
////                print(boxOffice)
////            }
//            networkManager.fetchData(
//                requestURL: requestURL,
//                sessionConfiguration: .default) { (individualMovieDetailInfomation: IndividualMovieDetailInfomation) in
//                print("individualMovieDetailInfomation: \(individualMovieDetailInfomation)")
//            }
//        } catch {
//            print(error.localizedDescription)
//        }
        
   
//        do {
//            let endPoint = try EndPoint().urlRequestGenerate(
//                baseURL: "http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json",
//                queryParameters: [
//                    "key": "d4bb1f8d42a3b440bb739e9d49729660",
//                    "targetDt": "20230724"
//                ]
//            )
//            let networkManager = NetworkManager()
//                networkManager.fetchData(
//                requestURL: endPoint,
//                completionHandler: { (boxOffice: BoxOffice) in
//                    print(boxOffice)
//                }
//            )
//        } catch {
//            print(error.localizedDescription)
//        }
        
        do {
            
            let endPoint = EndPoint(
                baseURL: "http://kobis.or.kr",
                queryParameters: [
                    "key": "d4bb1f8d42a3b440bb739e9d49729660",
                    "targetDt": "20230724"
                ]
            )

            let url = try endPoint.urlGenerate(
                paths: [
                    "/kobisopenapi",
                    "/webservice",
                    "/rest",
                    "/boxoffice",
                    "/searchDailyBoxOfficeList.json"
                ],
                isFullPath: false
            )
            
            let endpoint2 = EndPoint(baseURL: "http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=f5eef3421c602c6cb7ea224104795888&targetDt=20120101")
            let url2 = try endpoint2.urlGenerate(paths: nil, isFullPath: true)
            let urlRequest = URLRequest(url: url2)

            let networkManager = NetworkManager()
            networkManager.fetchData(
                requestURL: urlRequest) { (boxOffice: BoxOffice) in
                    print(boxOffice)
                }
            
        } catch {
            print(error.localizedDescription)
        }
        
    }
}

