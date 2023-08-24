//
//  DetailViewController.swift
//  BoxOffice
//
//  Created by Kobe, yyss99 on 2023/08/13.
//

import UIKit
import OSLog

class DetailViewController: UIViewController {
    private var boxOfficeDataFetcher: BoxOfficeDataFetcher?
    private var movieInformation: MovieInformation?
    private var movieCode: String?
    private let networkManager: NetworkManager = NetworkManager()
    
    convenience init(movieCode: String) {
        self.init(nibName: nil, bundle: nil)
        self.movieCode = movieCode
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func loadData() {
        guard let movieCode = movieCode else { return }
        
        let items = boxOfficeDataFetcher?.fetchDataBoxOfficeData(
            networkManager: networkManager,
            queryParameters: ["movieCode": movieCode]
        )
        
        guard let items = items else { return }
        items.forEach {
            
        }
    }
    
}


