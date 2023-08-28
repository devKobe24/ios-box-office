//
//  JSONDecoder.swift
//  BoxOffice
//
//  Created by Minseong Kang on 2023/08/27.
//

import UIKit

struct JSONDecoderProtocol: JSONDecodabler {
    
    func decodeJSON<Value: Decodable>(fileName: String) throws -> Value {
        
        let decoder = JSONDecoder()
        
        guard let dataAsset = NSDataAsset(name: fileName) else {
            throw DataError.invalidAsset
        }
        
        guard let decodeData: Value = try? decoder.decode(Value.self, from: dataAsset.data) else {
            throw DataError.failedDecoding
        }
        
        return decodeData
    }
    
    static func decodeJSON<Value: Decodable>(type: Value.Type, data: Data) throws -> Value {
        
        let decoder = JSONDecoder()
        
        guard let decodedData: Value = try? decoder.decode(type, from: data) else {
            throw DataError.failedDecoding
        }
        
        return decodedData
    }
}
