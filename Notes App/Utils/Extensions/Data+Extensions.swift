//
//  Data+Extensions.swift
//  Notes App
//
//  Created by Simran Preet Singh Narang on 2022-01-07.
//

import Foundation

extension Data {
    // Converts JSON data to specified object
    func converData<T : Decodable>(toType type: T.Type,
                                     dateDecodingStrategy: JSONDecoder.DateDecodingStrategy? = nil,
                                     keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy? = nil) throws -> T {
        let decoder = JSONDecoder()
        
        if let dateDecodingStrategy = dateDecodingStrategy {
            decoder.dateDecodingStrategy = dateDecodingStrategy
        }
        
        if let keyDecodingStrategy = keyDecodingStrategy {
            decoder.keyDecodingStrategy = keyDecodingStrategy
        }
        
        return  try decoder.decode(T.self, from: self)
    }
}
