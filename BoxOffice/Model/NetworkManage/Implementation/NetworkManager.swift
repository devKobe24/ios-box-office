//
//  NetworkManager.swift
//  BoxOffice
//
//  Created by Minseong Kang on 2023/08/19.
//

import Foundation

struct NetworkManager: Gettable {
    func getBoxOfficeData<T: Decodable>(requestURL: URLRequest, completionHandler: @escaping (T) -> Void) {
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
