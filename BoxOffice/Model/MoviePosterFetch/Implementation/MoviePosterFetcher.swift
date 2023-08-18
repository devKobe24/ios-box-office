//
//  MoviePosterFetcher.swift
//  BoxOffice
//
//  Created by Minseong Kang on 2023/08/18.
//

import Foundation

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
        completion: @escaping (String) -> Void
    ) {
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
            
            let config = ApiDataNetWorkConfigurer(
                baseURL: url,
                headers: headers,
                queryParameters: queryParameters
            )
            
            let urlRequest = try generateURLRequest(config: config)
            
            networkManager.getBoxOfficeData(requestURL: urlRequest) { (moviePoster: KakaoImageSearchResult) in
                let moviePosterURL = moviePoster.documents[0].imageUrl
                guard let moviePosterImageURL = MoviePoster(imageUrl: moviePosterURL).imageUrl else { return }
                completion(moviePosterImageURL)
            }
        } catch {
            print(error.localizedDescription)
        }
    }

}

