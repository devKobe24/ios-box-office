//
//  MoviePosterFetcher.swift
//  BoxOffice
//
//  Created by Minseong Kang on 2023/08/18.
//

import UIKit

class MoviePosterFetcher: MoviePosterFetchable {
    var baseURL: String
    var queryItems: [String : String]?
    var headerParameters: [String : String]?
    
    init(baseURL: String,
         queryItems: [String : String]? = nil,
         headerParameters: [String : String]? = nil
    ) {
        self.baseURL = baseURL
        self.queryItems = queryItems
        self.headerParameters = headerParameters
    }
    
    func fetchMoviePoster(
        networkManager: NetworkManager,
        headers: [String: String],
        queryParameters: [String: String],
        completion: @escaping (Result<UIImage?, FetchDayilyBoxOfficeDataError>) -> Void
    ) {
        queryParameters.forEach { [weak self] (key, value) in
            self?.queryItems = [key: value]
        }
        
        do {
            let networkConfigurer = NetworkConfigurer(
                baseURL: baseURL,
                queryItems: queryParameters,
                headerParameters: headers
            )
            
            let url = try networkConfigurer.generateURL(isFullPath: false)
            
            let config = ApiDataNetWorkConfigurer(
                baseURL: url,
                headers: headers,
                queryParameters: queryParameters
            )
            
            let urlRequest = try networkConfigurer.generateURLRequest(config: config)
            
            networkManager.getData(requestURL: urlRequest) { (moviePoster: KakaoImageSearchResult) in
                let moviePosterURL = moviePoster.documents[0].imageUrl
                guard let moviePosterImageURL = MoviePoster(imageUrl: moviePosterURL).imageUrl else {
                    return
                }
                
                guard let url = URL(string: moviePosterImageURL) else { return }
                
                // MARK: - 이거 쓰면 안됨, 바꿔야함 -> 메서드 다시 호출하기
                guard let data = try? Data(contentsOf: url) else {
                    return
                }
                guard let posterImg = UIImage(data: data) else {
                    return
                }
                completion(.success(posterImg))
            }
        } catch {
            completion(.failure(FetchDayilyBoxOfficeDataError.failToFetch))
            print(FetchDayilyBoxOfficeDataError.failToFetch.description)
        }
    }

}

