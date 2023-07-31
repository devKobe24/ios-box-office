//
//  NetworkManager.swift
//  BoxOffice
//
//  Created by Kobe, yyss99 on 2023/07/28.
//

import Foundation
// SOLID 원칙, 내부 분리 필요
// SRP
// DIP
public protocol fetchable {
    func fetchData<T: Decodable>(requestURL: URLRequest, completionHandler: @escaping (T) -> Void)
}
struct NetworkManager: fetchable {
    func fetchData<T: Decodable>(requestURL: URLRequest, completionHandler: @escaping (T) -> Void) {
        // URLSession.shared.dataTask 이것을 사용하고 있는데, sessionConfiguration을 사용할 필요는 없음,
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
