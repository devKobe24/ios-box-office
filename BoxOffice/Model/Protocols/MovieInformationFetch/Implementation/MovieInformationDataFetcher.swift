//
//  MovieInformationDataFetcher.swift
//  BoxOffice
//
//  Created by Minseong Kang on 2023/08/23.
//

import Foundation

final class MovieInformationDataFetcher: MovieInformationDataFetchable {
    private var movieCode: String?
    
    init(movieCode: String?) {
        self.movieCode = movieCode
    }
    
    func fetchMoviewInformationData(
        with movieCode: String,
        completion: @escaping (Result<MovieInformation?, Error>
        ) -> Void) {
        let networkManager: NetworkManager = NetworkManager()
//        let boxOfficeDataFetchet: BoxOfficeDataFetcher = .movieCode(movieCode)
//
//        guard let baseURL = boxOfficeDataFetchet.url else {
//            return
//        }
        guard let mockURL = URL(string: "www.naver.com") else {
            return
        }
        let urlRequest = URLRequest(url: mockURL)
        
        networkManager.getData(requestURL: urlRequest) { (movieInformation: MovieInformation) in
            
        }
        
        let task = URLSession.shared.dataTask(with: mockURL) { (data, response, error) in
            if error != nil  {
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
            
//            completion(.success(data))/
        }
        task.resume()
    }
}
