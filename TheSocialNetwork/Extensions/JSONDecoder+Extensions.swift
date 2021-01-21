//
//  JSONDecoder.swift
//  TheSocialNetwork
//
//  Created by Muhammad Arslan Asim on 18.01.21.
//


import Foundation

extension JSONDecoder {

    static let `default` = JSONDecoder(dateDecodingStrategy: .iso8601)
    
    convenience init(dateDecodingStrategy: DateDecodingStrategy) {
        self.init()

        self.dateDecodingStrategy = dateDecodingStrategy
    }
}
