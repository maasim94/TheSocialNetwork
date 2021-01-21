//
//  ModelDecoder.swift
//  nyzzu
//
//  Created by Muhammad Arslan Asim on 18.01.21.
//  
//

import Foundation

protocol ModelDecoder {

    func decode<T: Decodable>(_ type: T.Type, from data: Data) throws -> T
}

extension JSONDecoder: ModelDecoder { }

extension ModelDecoder {

    func decode<T: Decodable>(from data: Data) throws -> T {
        return try self.decode(T.self, from: data)
    }
}
