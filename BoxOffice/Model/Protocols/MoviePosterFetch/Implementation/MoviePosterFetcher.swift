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
    
    func fetchDataForMoviePosterWithURL(
        completion: @escaping (Result<Data?, NetworkError>) -> Void)
    {
        guard let url = URL(string: baseURL) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                completion(.failure(NetworkError.requestFailed))
                
                return
            }
            
            guard let httpReponse = response as? HTTPURLResponse,
                  (200...299).contains(httpReponse.statusCode) else {
                completion(.failure(NetworkError.invalidResponse))
                
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.emptyData))
                
                return
            }
            
            completion(.success(data))
        }
        
        task.resume()
    }
    
    func fetchDataForMoviePoster(
        urlRequest: URLRequest?,
        completion: @escaping (Result<Data?, NetworkError>) -> Void)
    {
        guard let urlRequest = urlRequest else { return }
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if error != nil {
                completion(.failure(NetworkError.requestFailed))
                
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(NetworkError.invalidResponse))
                
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.emptyData))
                
                return
            }
            
            completion(.success(data))
        }
        
        task.resume()
    }
    
    func fetchMoviePoster(
        completion: @escaping (Result<UIImage?, NetworkError>) -> Void)
    {
        fetchDataForMoviePosterWithURL() { result in
            switch result {
            case .success(let data):
                guard let data = data,
                      let image = UIImage(data: data) else { return }
                completion(.success(image))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

