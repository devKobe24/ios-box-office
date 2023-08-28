//
//  NetworkManager.swift
//  BoxOffice
//
//  Created by Minseong Kang on 2023/08/19.
//

import Foundation

struct NetworkManager: NetworkManagerable {
    
    func getData<T: Decodable>(requestURL: URLRequest, completionHandler: @escaping (T) -> Void) {
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
                let receivedData = try JSONDecoder().decode(T.self, from: data)
                completionHandler(receivedData)
            } catch let error as NetworkManagerError {
                print(error.localizedDescription)
            } catch {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
}

extension NetworkManager {
    
    func fetchData(with url: URL?, completion: @escaping (Result<Data?, NetworkError>) -> Void) {
        guard let url = url else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
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
}

extension NetworkManager {
    
    func fetchData(with urlRequest: URLRequest?, completion: @escaping (Result<Data?, NetworkError>) -> Void) {
        guard let urlRequest = urlRequest else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
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
            
            completion(.success(data))
        }
        
        task.resume()
    }
}

extension NetworkManager {
    
    func fetchMoviePosterImage(with url: URL?, completion: @escaping (Result<Data?, NetworkError>) -> Void) {
        guard let url = url else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
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
}
