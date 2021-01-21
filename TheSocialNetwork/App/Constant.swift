//
//  Constant.swift
//  TheSocialNetwork
//
//  Created by Muhammad Arslan Asim on 18.01.21.
//

import Foundation

struct Constants {
    
    static var baseURL: String {
        return "https://jsonplaceholder.typicode.com/"
    }
    
    static let timeout: TimeInterval = 60
    
    static let cacheTimeKey = "creationTime"
    static var cacheTimeExpiry: Int = 24 // hours
}

typealias CompletionVoid = (() -> Void)
