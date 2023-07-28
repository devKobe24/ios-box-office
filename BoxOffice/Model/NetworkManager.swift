//
//  NetworkManager.swift
//  BoxOffice
//
//  Created by Kobe, yyss99 on 2023/07/28.
//

import Foundation

struct NetworkManager {
    func makeURLRequest(baseURL: String, queryItems: [URLQueryItem]) throws -> URLRequest {
        guard var baseURL = URL(string: baseURL) else {
            throw MakeURLRequestError.convertURL
        }
        
        baseURL.append(queryItems: queryItems)
        
        let requestURL = URLRequest(url: baseURL)
        
        return requestURL
    }
    
    func fetchData<T: Decodable>(requestURL: URLRequest, sessionConfiguration: URLSessionConfiguration, completionHandler: @escaping (T) -> Void) {
        let task = URLSession.shared.dataTask(with: requestURL) { data, response, error in
            guard error == nil else {
                return
            }
            
            let successStatusRange = 200..<300
            guard let response = response as? HTTPURLResponse,
                  successStatusRange.contains(response.statusCode) else {
                return
            }
            
            guard let data = data else {
                return
            }
            
            do {
                let receviedDate = try JSONDecoder().decode(T.self, from: data)
                completionHandler(receviedDate)
            } catch let error {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
}
