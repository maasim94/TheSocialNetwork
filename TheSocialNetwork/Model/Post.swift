//
//  Posts.swift
//  TheSocialNetwork
//
//  Created by Muhammad Arslan Asim on 18.01.21.
//

import Foundation

struct Post: Codable {
    
    let userId: Int
    let id: Int
    let title: String
    let body: String
}
